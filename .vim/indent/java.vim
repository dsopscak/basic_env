" Vim indent file
" Language:	Java
" Maintainer:	Skip
" Copied from C#, just do it like C

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" Java is like indenting C
setlocal cindent

let b:undo_indent = "setl cin<"
