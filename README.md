# S3 Streamer

Stream a file from a remote url using the Ruby AWS SDK to an Amazon S3 bucket.
This tool uses the Multipart Upload API, that only makes sense for large files, where chunk transfer is necessary.

## Benchmarks
Using, default chunk size, S3 as source

* 85.7 MB with a 10/1.25 MBps connection
  Uploaded in 3 parts in 91.079307 seconds (0.93 MBps)
  Using less than 200MB RAM

## Install
Add to Gemfile or install with `gem install s3-streamer`

## Usage example
See the spec.
