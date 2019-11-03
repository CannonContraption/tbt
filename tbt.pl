#!/usr/bin/perl

use strict;

if ($#ARGV > 1)
{
    if ($ARGV[1] == "done")
    {
        `cat $ARGV[0] | tail -n +2 | tee $ARGV[0]`
    }
}

# Open the planner file.
open( my $filehandler, "<", $ARGV[0])     or die ("File $ARGV[0] can't be found!");

# Setup information. We're looping through a file, so it makes sense to have most of
# this defined and out of the way with early.

my $totalminutes = 0;             # Total minutes including current task
my $itemno       = 1;             # Item number
my $fromlast     = 0;             # Time between last task and this one
my $currenttime  = `date +%H:%M`; # Current Time

# By default, shell commands have a newline at the end. We need to get rid of it.
chomp $currenttime;

# Processing the current time. This is one way to give start times for tasks. This
# program isn't designed to beep when it's time, just print out time values,
# therefore this is all we really need to do.
my @timesplit    = split(/:/, $currenttime); # minutes in [1], hours in [0]. Like a clock.

# Print our table headers
print "\033[7;33m                                    │ Description                  ░░▒▒▓▓",
    "\r                           │ Time",
    "\r             │ Duration",
    "\r      │ in",
    "\rNo.\n\033[m";
print "──────┼──────┼─────────────┼────────┼────────────────────────────────╌╌┄┈\n";
# Now we can read and parse the input file with the todos we have for today. As they get
# completed, there can be a function to strip the first line of the file off or
# something.
READALINE: while ( ! eof ($filehandler) )
{
    # Read a line if we can. If it's undefined, there's a problem with the file, so exit.
    defined( $_ = readline $filehandler ) or die ("Can't read the whole file!");
    
    next READALINE if $_ =~ /^#/; #Discard comment lines
    next READALINE if $_ =~ /^$/; #Discard blank lines

    # The time is before the line item with a tab separating them. Split at the tab.
    my @splitline = split(/	/);

    # If the time ends in m, add the numeric value in minutes.
    if ($splitline[0] =~ /\d+m/)
    {
        chop $splitline[0];
        $fromlast = $splitline[0];
    }
    
    # If the time ends in h, add the numeric value in hours.
    elsif ($splitline[0] =~ /\d+h/)
    {
        chop $splitline[0];
        $fromlast = ($splitline[0] * 60);
    }

    # if the time end in d, add the numeric value in days.
    elsif ($splitline[0] =~ /\d+d/)
    {
        chop $splitline[0];
        $fromlast = ($splitline[0] * 60 * 24);
    }

    # If the time does not have a delimiter, assume minutes.
    elsif ($splitline[0] =~ /\d+/)
    {
        $fromlast = $splitline[0];
    }

    # The format isn't right. Inform the user and give up.
    else
    {
        die("Found a bad line. Make sure line =~ /time[mhd]\\tdescription/");
    }

    chomp ($splitline[1]);

    if ($splitline[1] =~ //)
    {
        die("Found a bad line. Make sure line =~ /time[mhd]\\tdescription/");
    }
    
    my $hours   = int($fromlast / 60);
    my $minutes = int($fromlast % 60);

    print "                                    │ $splitline[1]",
        "\r                           │ \033[31m$timesplit[0]:$timesplit[1]\033[m",
        "\r             │ \033[32m($hours h, $minutes m)\033[m",
        "\r      │ \033[33m$totalminutes","m\033[m",
        "\r\033[1;33m$itemno:\n\033[m";

    $timesplit[0] += $hours;
    $timesplit[1] += $minutes;
    if ($timesplit[1] >= 60)
    {
        $timesplit[0] += int ($timesplit[1] / 60);
        $timesplit[1] =  int ($timesplit[1] % 60);
    }
    
    $itemno++;
    $totalminutes += $fromlast;
}

my $totalhours = int($totalminutes / 60);
$totalminutes  = int($totalminutes % 60);
print "\n\033[1;36mThis list has a total estimated completion time of $totalhours:$totalminutes.\033[m\n";

close($filehandler);
