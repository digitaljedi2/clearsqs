#!/usr/bin/perl
##
# Clears an Amazon SQS queue, optionally dumping the contents to stdout.
##
use Amazon::SQS::Simple;
use Getopt::Long;

my $accesskey;
my $secretkey;
my $queuename;
my $dump = 0;

GetOptions ("accesskey=s" => \$accesskey,
            "secretkey=s" => \$secretkey,
            "queue=s"     => \$queuename,
            "dump"        => \$dump);


if (defined $accesskey && defined $secretkey && defined $queuename) {
    my $sqs = new Amazon::SQS::Simple($accesskey, $secretkey);

    if ($sqs) {
        my $queue = $sqs->GetQueue($queuename);
        if ($queue) {
            while(my $msg = $queue->ReceiveMessage()) {
                if ($dump) {
                    print $msg->MessageBody(),"\n";
                }
                $queue->DeleteMessage($msg->ReceiptHandle());
            }
        }
    }
}else{
    print <<HELP;

Clears an SQS queue of all queued messages and optionally writes them to stdout.

Usage:

    $0 --accesskey <access key> --secretkey <secret key> --queue <queue url> [--dump]    
    --accesskey - The Amazon account's access key
    --secretkey - The Amazon account's secret access key
    --queue     - The absolute URL to the SQS queue
    --dump      - Writes each queue value to stdout

HELP
}
