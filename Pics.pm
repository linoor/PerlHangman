package Pics;
use strict;
use warnings;

our @ISA = qw(Exporter);
our @EXPORT = qw(@hangmanpics);
our @EXPORT_OK = qw(@hangmanpics);

our @hangmanpics = ("

   +---+
   |   |
       |
       |
       |
       |
 =========", "

   +---+
   |   |
   O   |
       |
       |
       |
 =========", "

   +---+
   |   |
   O   |
   |   |
       |
       |
 =========", "

   +---+
   |   |
   O   |
  /|   |
       |
       |
 =========", "

   +---+
   |   |
   O   |
  /|\\  |
       |
       |
 =========", "

   +---+
   |   |
   O   |
  /|\\  |
  /    |
       |
 =========", "

   +---+
   |   |
   O   |
  /|\\  |
  / \\  |
       |
 =========");
