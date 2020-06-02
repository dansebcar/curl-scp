# scp vs scp+curl server side return code

First `source docker/source.sh`

Then run `up` to start the container and `sshd` on port 8022.

Then, outside the container, observe that

`test-scp /some/file`

copies the file successfully (password is `my-pass`), and `/tmp/log` shows a zero exit status, whereas

`test-curl /some/file`

shows exit status 1 (server side, the client side still returns 0), even though the file is still copied successfully (I'm not sure why `--insecure` is needed for the demo but that's irrelevant to my issue).

The sshd `/var/log/sshd` error log doesn't give any indication why the return status was non-zero, and using `--verbose` on the client side doesn't suggest that anything went wrong.

## Observations

Inspecting the server side scp command's stdin (`od -ta /tmp/in` after copying) shows that it was passed a header line "C0644 length filename", followed by the file's contents.

If scp was used client side, a null terminator is also included. If curl was used client side, no null is passed.

The `fake-scp` command shows, dependeding on whether or not it's passed any arguments, that the server side scp will exit with 0 if its stdin was null-terminated, otherwise it exits with 1.
