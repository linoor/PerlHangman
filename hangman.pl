#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use Pics;

my ($miss, $guesses, $guess, @hidden, $tries, @guessed, @wordbank);

sub get_random_word{
	my @wordbank = @_;
	my $selected = rand(scalar(@wordbank));
	return split(//, $wordbank[$selected]);
}

@wordbank = qw(cubicle scramble deduction envelope century ridiculous);
my @word = get_random_word(@wordbank);

@hidden = ("_") x scalar(@word);

$miss = 0;
$guesses = 0;
$tries = 0;

print "Welcome to hangman\n";
print "Your word has "; print scalar(@word); print " guesses";

print @hangmanpics;
