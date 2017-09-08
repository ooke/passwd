# PasS/KEY

This is a project to build a password management tool based on the
S/Key system described in the
[RFC2289](https://tools.ietf.org/html/rfc2289). This password manager
is made with following goals in mind:

1. Password need to be memorable, secure and easy to type on any
   keyboard.
   
   The passwords which are generated with PasS/KEY can be momoized and
   used without the generator. Generate the passwords only if you
   forgot a password, it reduces the number of times you enter your
   master password dramatically.

1. It should work every where.

   In fact you even do not require this particular tool, but can use
   any tool which is capable of generating S/Key SHA-1 passwords. So
   you have the garantee, that you can generate the password also
   without access to this particular tool. For most UNIX systems you
   can install the `skey` or equivalent command, which also generate
   exactly the same passwords.
   
1. You should be able to use it in a safe way even if the whole time
   you generate a password sombody look on your screen.
   
   With PasS/KEY you can generate your passwords securely, also if
   somobody look on your screen and you are on a foreign PC. (do not
   generate passwords on devices that you do not trust!)
   
1. It should work offline and should never send anything through
   network.
   
   Files from this repository and a browser are enought to use this
   tool, you do not need to install something. It is also usable on
   any smart phone or similar devices, also without permanent
   connection to the internet.
   
1. It should not store anything anywhere and should be also usable on
   foreign systems.

Live Demo: https://ooke.github.io/sk/

# General use case

This is password manager, you need a main password (`secret` field)
and you can generate a password based on a name (`seed`
field). Typical usage:

1. Enter a name to the `seed` field, f.e. if you need a password for
   Amazon, than enter `amazon` here. It is also possible to enter
   `amazonXX` with any number of `X` after the name, in this case the
   system will replace all `X` characters with a random number with
   maximum number of digits equals to number of `X` entered.
   
1. If the system you need a password for require a password with
   special characters, than enter a string in `prefix` field. You can
   use the same prefix string on all passwords, usualy something like
   `#A0`. This field do not really add any security, it is only to
   give dump systems the character classes they want.
   
1. Enter your master password in the field `secret`. If you click on
   the label `secret` then the system make the password visible,
   usually to verify that you entered the password correctly. If you
   do not want unhide the password, but you are not sure if it is
   entered correctly, than you can enter the password in the `verify`
   field a second time.

1. Click on button `calculate` to calculate the password and the
   password will be calculated and entered in the fields at the
   bottom in following representations:
   
   1. Usual 6 words S/Key representation.

      If possible, please use this representation, because it is easy
      to type, to remember and have no problems with special
      characters.
  
   1. Usual 6 words S/Key representation with `-` character instead of
      space
      
      This representation should be used, if no space is allowed in
      the target system.
      
   1. Hex representation of the password
   
      Use this representation, if you have length or other strange
      limits on password.
   
   1. Base64 representation without `=` character for padding
   
      Most systems with the (officially deprecated and dangerous)
      constraints on character classes in password will accept this
      representation.
   
   1. Decimal representation
   
      Some systems allow only numbers, like PIN systems. Please youse
      so many numbers from this representation you need.
      
1. Click on the choosen represtation and on the button `copy
   selected`, if this button do not work on your browser, than simple
   select the full text in the field (f.e. through tripple click with
   the mouse or regular text selection). The password is not visible
   but selectable, so you do not need to click on `show` button to
   copy/paste the password.

This password manager do not store any names or passwords and do not
communicate with anything, all calculations are done within your
browser. Common way is to write down the meta information about each
generated password, I use [Evernote](http://www.evernote.com) for it,
and notice there following:

- URL of the web page or similar
- Exact `seed` I have used
- Representation used (type, prefix, number of digits for decimal)
- Date on which the password was generated or changed
- Login name, birthday entered and similar meta data

The `seed` has no security value, so you do not need to encrypt this
information, only your secret should really be secret.

Usually you do not need to change the `seq #` field, it is only needed
if you use this password manager as a S/Key calculator, playing with
the `seq #` without knowing what you are doing is dangerous.

# S/Key usage

This password manager can be used as a S/Key calculator, if you login
to a system with enabled S/Key athentication method, then type the
sequence number, seed and secret, click on `calculate` and copy/paste
your password.

Warning: only SHA-1 S/Key mode is supported and S/Key is not safe to
use, if any one could see your password. Do not use it through
unencrypted connections!

This use case is usefull, if your need f.e. login to your server from
a PC, which you do not trust (internet caffee f.e.). You could use
PasS/KEY on your smartphone to calculate the one time password and
type it on this PC. Also if some body logs the keyboard, this password
is usable only one single time.

# Hierarchical passwords

It is possible to use multiple master passwords in a hierarhical way:

1. Type a `seed` name for the master password

1. Type your mastermaster password in `secret` field

1. Click on `calculate` and on `switch`

1. Type the name of page you need the password for in `seed`

1. Click on `calculate` and use it as usual

The reason to hierarchical passwords is to use own master passwords
for different types of systems. Typically you memoize the generated
master password and use it, instead of using the mastermaster
password. In this way, if you loose the master password you need only
reset the password on a bunch of services intstead of all services.

For example I use one master password for home, one for work and one
for regular web pages. All of the master passwords are generatable
but I memoize them and do typically never type the mastermaster
password somewhere.

# Security considerations

This password manager was inspired by the XKCD commic:

[![password_strength](https://imgs.xkcd.com/comics/password_strength.png)](https://www.xkcd.com/936/)

Internally it calculates SHA-1 checksum chained `seq #` number of
times from `seed` and `secret` concatenated together. The result is
reduced to a 64 bit number and represented as 6 words, with the scheme
from [RFC2289](https://tools.ietf.org/html/rfc2289). Other
representations are simply different representations of this 64 bits.

The [SHA-1](https://en.wikipedia.org/wiki/SHA-1) is considered as
insecure, because it is possible to generate multiple documents whith
same checksum. This weakness do not apply here, because the
possibility to genarate multiple seed/secret combinations which
creates same password is irrelevant for the use case here.

Also S/Key is considered as insecure, because it is unsafe to use it
on unencrypted links. Do not use unencrypted interfaces or systems,
where some body could read your password, S/Key, OTP or this password
manager will not help you in such cases.

Do not generate passwords on devices that you do not trust!
