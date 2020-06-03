# scp vs scp+curl server side return code

First `source docker/source.sh`

Then run `up` to start the container and `sshd` on port 8022.

The container's `/usr/bin/scp` is shadowed by `/usr/local/bin/scp` which wraps the former and additionally writes its exit code to `/tmp/log`.

Then, outside the container, observe that

`test-scp /some/file`

copies the file successfully (to /tmp/hello) (password is `my-pass`), and `/tmp/log` shows a zero exit status, whereas

`test-curl /some/file`

shows exit status 1 (server side, the client side still returns 0), even though the file is still copied successfully (I'm not sure why `--insecure` is needed for the demo but that's irrelevant to my issue).

The sshd `/var/log/sshd` error log doesn't give any indication why the return status was non-zero, and using `--verbose` on the client side doesn't suggest that anything went wrong.
