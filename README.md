# clearsqs

## Introduction

This is a simple script in Perl that will clear out an Amazon SQS queue.

I've found this useful since the alternative is to delete and re-recreate the queue with the same name.

## Usage

    ./clearsqs.pl --accesskey <access key> --secretkey <secret key> --queue <queue url> [--dump]    
        --accesskey - The Amazon account's access key
        --secretkey - The Amazon account's secret access key
        --queue     - The absolute URL to the SQS queue
        --dump      - Writes each queue value to stdout

