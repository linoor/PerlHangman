#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use Pics;

my ($miss, $guesses, $guess, @blanks, $tries, @guessed, @wordbank, $letter);

sub get_random_word{
	my @wordbank = @_;
	my $selected = rand(scalar(@wordbank));
	return split(//, $wordbank[$selected]);
}

sub display_board{
	my ($hangman_pics, $missed_letters, $correct_letters, $secret) = @_;
	my @hangman_pics    = @{$hangman_pics};
	my @missed_letters  = @{$missed_letters};
	my @correct_letters = @{$correct_letters};
	my $secret_word     = ${$secret};

	print $secret_word;

	print $hangman_pics[scalar(@missed_letters)];
	print "\n";

	print "Missed letters: ";
	foreach my $letter (@missed_letters){
		print $letter;
		print " ";
	}
	print "\n";

	my @blanks = ("_") x length($secret_word);

	for (my $i=0; $i < length($secret_word); $i++) {
	}

	my $interspersed = ""; 
	foreach my $c(split //, $secret_word) {
		if ($c ~~ $correct_letters) {
			$interspersed = $interspersed.$c;
		} else {
			$interspersed = $interspersed."_";
		}
	}

	foreach $letter (split //, $interspersed){
		print $letter;
		print " ";
	}
}

my @missed_letters = ("a", "b");
my @correct_letters = ("m");
my $secret_word = "loremipsum";

display_board(\@hangmanpics, \@missed_letters, \@correct_letters, \$secret_word);

@wordbank = qw(cubicle scramble deduction envelope century ridiculous);
my @word = get_random_word(@wordbank);

$miss = 0;
$guesses = 0;
$tries = 0;

print "Welcome to hangman\n";
print "Your word has "; print scalar(@word); print " guesses";
