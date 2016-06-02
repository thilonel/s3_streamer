[![Build Status](https://travis-ci.org/thilonel/s3_streamer.svg?branch=master)](https://travis-ci.org/thilonel/s3_streamer)

# S3 Streamer

Stream a file from a remote url using the Ruby AWS SDK to an Amazon S3 bucket.
This tool uses the Multipart Upload API, that only makes sense for large files, where chunk transfer is necessary.

## Benchmarks
Using, default chunk size, S3 as source

* 98 MB file with a 10/1.25 MBps connection
  Finished in 1 minute 35.84 seconds (1.02 MBps)
  226MB Peak memory usage

## Install
Add to Gemfile or install with `gem install s3-streamer`

## Usage example
See the spec.
