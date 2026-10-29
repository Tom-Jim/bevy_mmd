//! Little-endian cursor over a byte slice, shared by the PMX and VMD parsers.

use super::FormatError;

pub struct Reader<'a> {
    bytes: &'a [u8],
    pos: usize,
}

impl<'a> Reader<'a> {
    pub fn new(bytes: &'a [u8]) -> Self {
        Self { bytes, pos: 0 }
    }

    pub fn position(&self) -> usize {
        self.pos
    }

    pub fn remaining(&self) -> usize {
        self.bytes.len() - self.pos
    }

    pub fn is_empty(&self) -> bool {
        self.remaining() == 0
    }

    pub fn bytes(&mut self, n: usize) -> Result<&'a [u8], FormatError> {
        if n > self.remaining() {
            return Err(FormatError::Truncated { at: self.pos, wanted: n });
        }
        let out = &self.bytes[self.pos..self.pos + n];
        self.pos += n;
        Ok(out)
    }

    pub fn array<const N: usize>(&mut self) -> Result<[u8; N], FormatError> {
        Ok(self.bytes(N)?.try_into().unwrap())
    }

    pub fn u8(&mut self) -> Result<u8, FormatError> {
        Ok(self.array::<1>()?[0])
    }

    pub fn i8(&mut self) -> Result<i8, FormatError> {
        Ok(self.u8()? as i8)
    }

    pub fn u16(&mut self) -> Result<u16, FormatError> {
        Ok(u16::from_le_bytes(self.array()?))
    }

    pub fn i16(&mut self) -> Result<i16, FormatError> {
        Ok(i16::from_le_bytes(self.array()?))
    }

    pub fn u32(&mut self) -> Result<u32, FormatError> {
        Ok(u32::from_le_bytes(self.array()?))
    }

    pub fn i32(&mut self) -> Result<i32, FormatError> {
        Ok(i32::from_le_bytes(self.array()?))
    }

    pub fn f32(&mut self) -> Result<f32, FormatError> {
        Ok(f32::from_le_bytes(self.array()?))
    }

    pub fn vec2(&mut self) -> Result<[f32; 2], FormatError> {
        Ok([self.f32()?, self.f32()?])
    }

    pub fn vec3(&mut self) -> Result<[f32; 3], FormatError> {
        Ok([self.f32()?, self.f32()?, self.f32()?])
    }

    pub fn vec4(&mut self) -> Result<[f32; 4], FormatError> {
        Ok([self.f32()?, self.f32()?, self.f32()?, self.f32()?])
    }

    /// A count that prefixes a list. Rejects counts the remaining bytes cannot hold, so a
    /// corrupt file fails instead of allocating gigabytes.
    pub fn count(&mut self, min_item_size: usize) -> Result<usize, FormatError> {
        let at = self.pos;
        let n = self.i32()?;
        if n < 0 || (n as usize).saturating_mul(min_item_size.max(1)) > self.remaining() {
            return Err(FormatError::BadCount { at, count: n as i64 });
        }
        Ok(n as usize)
    }

    /// A PMX index of 1, 2 or 4 bytes. `-1` (any width) means "none".
    pub fn index(&mut self, size: u8) -> Result<i32, FormatError> {
        Ok(match size {
            1 => self.i8()? as i32,
            2 => self.i16()? as i32,
            4 => self.i32()?,
            _ => return Err(FormatError::Invalid(format!("index size {size}"))),
        })
    }

    /// A PMX vertex index: unsigned for 1 and 2 bytes.
    pub fn vertex_index(&mut self, size: u8) -> Result<u32, FormatError> {
        Ok(match size {
            1 => self.u8()? as u32,
            2 => self.u16()? as u32,
            4 => self.i32()? as u32,
            _ => return Err(FormatError::Invalid(format!("vertex index size {size}"))),
        })
    }
}

/// Text encodings of PMX headers and VMD names.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Encoding {
    Utf16,
    Utf8,
}

pub fn read_text(r: &mut Reader, encoding: Encoding) -> Result<String, FormatError> {
    let len = r.count(1)?;
    let bytes = r.bytes(len)?;
    Ok(match encoding {
        Encoding::Utf8 => String::from_utf8_lossy(bytes).into_owned(),
        Encoding::Utf16 => encoding_rs::UTF_16LE.decode_without_bom_handling(bytes).0.into_owned(),
    })
}

/// A fixed-size Shift-JIS field (VMD names), cut at the first NUL.
pub fn decode_sjis(field: &[u8]) -> String {
    let end = field.iter().position(|&b| b == 0).unwrap_or(field.len());
    encoding_rs::SHIFT_JIS.decode_without_bom_handling(&field[..end]).0.into_owned()
}

/// The Shift-JIS bytes of `text`, NUL padded (or cut) to `width` bytes.
pub fn encode_sjis(text: &str, width: usize) -> Vec<u8> {
    let (bytes, _, _) = encoding_rs::SHIFT_JIS.encode(text);
    let mut out = bytes.into_owned();
    out.resize(width, 0);
    out
}
