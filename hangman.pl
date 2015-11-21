#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use Pics;

my ($miss, $guesses, $guess, @blanks, $tries, @guessed, @wordbank);

sub get_random_word{
	my @wordbank = @_;
	my $selected = rand(scalar(@wordbank));
	return split(//, $wordbank[$selected]);
}

sub display_board{
	my ($hangman_pics, $missed_letters, $correct_letters, $secret_word) = @_;
	my @hangman_pics = @{$hangman_pics};
	my @missed_letters = @{$missed_letters};
	my @correct_letters = @{$correct_letters};
	my @secret_word = @{$secret_word};

	print $hangman_pics[scalar(@missed_letters)];
	print "\n";

	print "Missed letters: ";
	foreach my $letter (@missed_letters){
		print $letter;
		print " ";
	}
	print "\n";

	my @blanks = ("_") x length($secret_word);

	for (my $i=0; $i <= scalar(@secret_word); $i++) {
		if (index(@correct_letters, $secret_word[$i]) != -1) {
			$blanks[$i] = $secret_word[$i];
		}	
	}

	foreach my $letter (@blanks){
		print $letter;
		print " ";
	}
}

my @missed_letters = ("a", "b");
my @correct_letters = ("m");
my @secret_word = "loremipsum";

display_board(\@hangmanpics, \@missed_letters, \@correct_letters, \@secret_word);

@wordbank = qw(cubicle scramble deduction envelope century ridiculous);
my @word = get_random_word(@wordbank);

$miss = 0;
$guesses = 0;
$tries = 0;

print "Welcome to hangman\n";
print "Your word has "; print scalar(@word); print " guesses";
