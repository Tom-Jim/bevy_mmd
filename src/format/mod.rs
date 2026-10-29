//! PMX (model) and VMD (motion) files.
//!
//! The parsers keep the values of the file: MikuMikuDance's left-handed coordinates,
//! Euler angles in radians, Shift-JIS names decoded. `crate::anim::model` converts
//! them to the right-handed space the viewer draws in.

pub mod pmx;
pub mod reader;
pub mod vmd;

use std::fmt;

#[derive(Debug, Clone, PartialEq)]
pub enum FormatError {
    /// Not a PMX/VMD file (bad magic or version).
    Signature(String),
    /// The file ends inside a field.
    Truncated { at: usize, wanted: usize },
    /// A list length that the rest of the file cannot hold.
    BadCount { at: usize, count: i64 },
    Invalid(String),
}

impl fmt::Display for FormatError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Signature(what) => write!(f, "not a {what} file"),
            Self::Truncated { at, wanted } => write!(f, "file ends at byte {at} ({wanted} more bytes expected)"),
            Self::BadCount { at, count } => write!(f, "invalid list length {count} at byte {at}"),
            Self::Invalid(what) => write!(f, "{what}"),
        }
    }
}

impl std::error::Error for FormatError {}
