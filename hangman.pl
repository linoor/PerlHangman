#!/usr/bin/perl
# projekt zaliczeniowy w perlu
# Michał Pomarański
# grupa nr 3

use FindBin;
use lib $FindBin::Bin;
use Pics;
use strict;
use Getopt::Long;
use List::Util qw/shuffle/;
no warnings 'experimental';

my $help = 0;
my $easier_mode = 0;
my $shorter_words_mode = 0;
GetOptions ('help' => \$help,
			'c' => \$easier_mode,
			'r' => \$shorter_words_mode
) or die("Błąd podczas parsowania argumentów. Użyj --help aby zobaczyć pomoc.");
$help and &ShowHelp();

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

	system 'clear';

	print $hangman_pics[scalar(@missed_letters)];
	print "\n";

	print "Nieprawidłowe litery: ";
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
		print "Podaj literę:\n";
		$guess = <>;
		chomp($guess);
		if (length($guess) != 1) {
			print "Podaj tylko jedną literę.\n";
		} elsif (index("qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM", $guess) == -1) {
			print "Wybierz LITERĘ.\n";
		} elsif ($guess ~~ @already_guessed) {
			print "Ta litera już została użyta. Wybierz jeszcze raz.\n";
		} else {
			return $guess;
		}
	}
}

sub playAgain{
	print "Czy chcesz zagrać jeszcze raz? (tak/nie) ";
	my $again = <>;
	return $again =~ /^t/;
}

sub generate_words{
	my $wordlist = '/usr/share/dict/words';

	my $length = 10;
	my $numwords = 10;

	my @words;

	open WORDS, '<', $wordlist or die "Nie można otworzyć $wordlist:$!";

	while (my $word = <WORDS>) {
		chomp($word);
		if (length($word) == $length and index($word, "'") == -1) {
			push @words, $word;
		}
	}

	close WORDS;

	my @shuffled_words = shuffle(@words);
	return @shuffled_words;
}

@wordbank = generate_words();

$miss = 0;
$guesses = 0;
$tries = 0;

print "#### Wisielec ####\n";

my @missed_letters = ("");
my @correct_letters = ("");
my $secret_word = get_random_word(\@wordbank);
my $game_is_done = ""; # false

while (1) {
	display_board(\@Pics::hangmanpics, \@missed_letters, \@correct_letters, \$secret_word);
	print $secret_word;

	my @tmp_array = ();
	push @tmp_array, @missed_letters;
	push @tmp_array, @correct_letters;
	my $guess = get_guess(\@tmp_array);
	my $opposite_case_guess = "";

	if ($guess =~ /[A-Z]/) {
		$opposite_case_guess = lc $guess;
	} else {
		$opposite_case_guess = uc $guess;
	}

	if (index($secret_word, $guess) != -1
			or $easier_mode and index($secret_word, $opposite_case_guess) != -1) {

		if ($easier_mode) {
			push @correct_letters, $opposite_case_guess;
		}
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
			print "Brawo! Ukryte słowo to: $secret_word! Wygrałeś!\n";
			$game_is_done = 1;
		}
	} else {
		push @missed_letters, $guess;

		# check that the player has guessed too many times and lost
		if (scalar(@missed_letters) == (scalar(@Pics::hangmanpics)-1)) {
			display_board(\@Pics::hangmanpics, \@missed_letters, \@correct_letters, \$secret_word);
			print "Skończyły Ci się próby! Przegrałeś!\n";
			print "Ukrytym słowem było: $secret_word\n";
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
