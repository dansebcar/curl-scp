# scp vs scp+curl server side return code

First `source docker/source.sh`

Then run `up` to start the container and `sshd` on port 8022.

Then, outside the container, observe that

`scp -P 8022 /some/file my-user@127.0.0.1:/tmp`

copies the file successfully (password is `my-pass`), and `/tmp/log` shows a zero exit status, whereas

`curl --upload-file /some/file --insecure --user my-user:my-pass scp://127.0.0.1:8022/tmp`

shows exit status 1 (server side, the client side still returns 0), even though the file is still copied successfully (I'm not sure why `--insecure` is needed for the demo but that's irrelevant to my issue).

The sshd `/var/log/sshd` error log doesn't give any indication why the return status was non-zero, and using `--verbose` on the client side doesn't suggest that anything went wrong.
