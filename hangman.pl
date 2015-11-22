#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use Pics;

my ($miss, $guesses, $guess, @blanks, $tries, @guessed, @wordbank, $letter);

sub get_random_word{
	my $ref = shift;
	my @wordbank = @{$ref};
	my $selected = rand(scalar(@wordbank));
	return $wordbank[$selected];
}

sub display_board{
	my ($hangman_pics, $missed_letters, $correct_letters, $secret) = @_;
	my @hangman_pics    = @{$hangman_pics};
	my @missed_letters  = @{$missed_letters};
	my @correct_letters = @{$correct_letters};
	my $secret_word     = ${$secret};

	print "DEBUG secret word: $secret_word";

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
	print "\n";
}

sub get_guess{
	my @already_guessed = shift;

	while(1) {
		print "Guess a letter:\n";
		$guess = <>;
		$guess = lc($guess);
		chomp($guess);
		if (length($guess) != 1) {
			print "Please enter a single letter.\n";
		} elsif ($guess ~~ @already_guessed) {
			print "You have already guesses that letter. Choose again.\n";
		} elsif (!$guess ~~ split //, "qwertyuiopasdfghjklzxcvbnm") {
			print "Please enter a letter.\n";
		} else {
			return $guess;
		}
	}
}

sub playAgain{
	print "Do you want to play again? (yes or no) ";
	my $again = <>;
	return $again =~ /^y/;
}

@wordbank = qw(cubicle scramble deduction envelope century ridiculous);

$miss = 0;
$guesses = 0;
$tries = 0;

print "Welcome to hangman\n";

my @missed_letters = ("");
my @correct_letters = ("");
my $secret_word = get_random_word(\@wordbank);
my $game_is_done = ""; # false

print "DEBUG chosen word: $secret_word";

while (1) {
	display_board(\@hangmanpics, \@missed_letters, \@correct_letters, \$secret_word);

	my @tmp_array = ();
	push @tmp_array, @missed_letters;
	push @tmp_array, @correct_letters;
	my $guess = get_guess(\@tmp_array);

	print "DEBUG guess $guess";
	if (index($secret_word, $guess) != -1) {
		print "DEBUG i'm here\n";
		push @correct_letters, $guess;

		# check if the player has won
		my $found_all_letters = 1;
		for my $c (split //, $secret_word) {
			if (!($c ~~ @correct_letters)) {
				$found_all_letters = "";
				last;
			}
		}

		if ($found_all_letters) {
			print "Yes! The secret word is $secret_word! You have won!\n";
			$game_is_done = 1;
		}
	} else {
		push @missed_letters, $guess;

		# check that the player has guessed too many times and lost
		if (scalar(@missed_letters) == (scalar(@hangmanpics)-1)) {
			display_board(\@hangmanpics, \@missed_letters, \@correct_letters, $secret_word);
			print "You have run out of guesses!\n";
			$game_is_done = 1;
		}
	}

	if ($game_is_done) {
		if (playAgain()) {
			@missed_letters = ();
			@correct_letters = ();
			$game_is_done = "";
			$secret_word = get_random_word(\@wordbank);
		} else {
			last;
		}
	}
}
