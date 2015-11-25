#!/usr/bin/perl
# projekt zaliczeniowy w perlu
# Michał Pomarański
# grupa nr 3

package Pics;
use strict;
use warnings;

use Getopt::Long;
my $help = 0;

sub ShowHelp {
	print "\n";
	print "###################################################################\n";
	print "#                         Gra Wisielec.                           #\n";
	print "#                                                                 #\n";
	print "# Uruchamianie gry za pomocą 'perl hangman.pl'.                   #\n";
	print "# Gra polega na zgadywaniu wylosowanego słowa poprzez podawanie   #\n";
	print "# pojedyńczych liter. W przypadku zbyt wielu pomyłek gra zostaje  #\n";
	print "# zakończona.                                                     #\n";
	print "# Gra pobiera losowe angielskie słowa z /usr/share/dict/words     #\n";
	print "# Opcje: [-c] - wyłączenie znaczenia wielkości liter. Domyślnie   #\n";
	print "# wielkość liter ma znaczenie.                                    #\n";
	print "###################################################################\n\n";
	exit;
}

our @ISA = qw(Exporter);
our @EXPORT = qw(@hangmanpics ShowHelp);
our @EXPORT_OK = qw(@hangmanpics ShowHelp);

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
