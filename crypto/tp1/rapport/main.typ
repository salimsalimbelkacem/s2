#set page(fill: rgb("#1a1a1a"))
#set text(fill: rgb("#e1e1e1"))


#show raw: set text(font: "Iosevka")


#show raw.where(block: true): block.with(
  fill: luma(35),
  inset: 10pt,
  radius: 4pt,
)

#text(size:24pt, weight:"bold")[Cryptography tp 1 repport]

#set heading(numbering: "1.a.")

= Remote shell with SSH
in this part i used 2 computers running a linux system ( `arch` for the client and `openSUSE` for the server ), to access one's shell using the other with `ssh`.

== Using password

- *command:*
```
$ ssh salim@192.168.1.19
```
- *output:*
```
(salim@192.168.1.19) Password:
Last login: Sun Feb 15 19:55:07 CET 2026 on tty1
Have a lot of fun...
salim@localhost:~
```

== Using ssh key
- *command:*
```
$ ssh-keygen -t rsa
```
- *output:*
```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/salim_belkacem/.ssh/id_rsa):
Enter passphrase for "/home/salim_belkacem/.ssh/id_rsa" (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/salim_belkacem/.ssh/id_rsa
Your public key has been saved in /home/salim_belkacem/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:IMIT5CKxtlriI9O+5B3wNFS5rW7CBScWmKfIciyhgoc salim_belkacem@archlinux
The key's randomart image is:
+---[RSA 3072]----+
|..oo  ..         |
|.=o.o..          |
|B*=oo..o         |
|Eo*++.o..        |
|+=o.o+ .S        |
|o+ + .o          |
|+oo.oo           |
|.=..o.o          |
|  +..o           |
+----[SHA256]-----+
```

- *command:*
```
$ ssh-copy-id salim@192.168.1.19
```

- *output:*
```
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/salim_belkacem/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
(salim@192.168.1.19) Password:

Number of key(s) added: 1

Now try logging into the machine, with: "ssh 'salim@192.168.1.19'"
and check to make sure that only the key(s) you wanted were added.``
```

- *command:*
```
$ ssh salim@192.168.1.19
```
- *output:*
```
Last login: Sun Feb 15 21:42:07 CET 2026 from 192.168.1.12 on ssh
Have a lot of fun...
salim@localhost:~>
```

= file encryption with openssl
- *input*
```
$ echo Ceci est un test de chiffrement par AES via openSSL. > TestAES.odt
```
`TestAES.odt`:
```
Ceci est un test de chiffrement par AES via openSSL. 
```

== Encryption
- *input*
```
$ openssl enc -e -aes-256-cbc -in TestAES.odt -out TestAES_Crypted.odt
```

- *output*

```
enter AES-256-CBC encryption password:
Verifying - enter AES-256-CBC encryption password:
*** WARNING : deprecated key derivation used.
Using -iter or -pbkdf2 would be better.
```

_inserted password was: salim_

`TestAES_Crypted.odt`:

```
Salted__���Wo�w�W���x���DB�Z!�
                              ��3�f7��C$�<�B��n�5�n�\���0������
```
== Decryption
- *input*
```
$ openssl enc -d -aes-256-cbc -in TestAES_Crypted.odt -out TestAES_Decrypted.odt
```
- *output*
```
enter AES-256-CBC decryption password:
*** WARNING : deprecated key derivation used.
Using -iter or -pbkdf2 would be better.
```

`TestAES_Decrypted.odt`:

```
Ceci est un test de chiffrement par AES via openSSL.
```
// Local Variables:
// typst-preview--master-file: "/home/salim_belkacem/m1/s2/crypto/tp1/rapport/main.typ"
// End:
