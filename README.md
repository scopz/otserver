# Open Tibia Server [![Build Status](https://travis-ci.org/opentibia/server.svg?branch=master)](https://travis-ci.org/opentibia/server)

OTServ is a free MMORPG emulation, that creates a own gameworld server,
based on the CIPSoft's Tibia.

This version of OpenTibia is based on the revscriptsys branch of OTServ,
and is as such NOT backwards-compatible with old distributions like TFS.
This has been done to greatly enhance the scripting system, moving to a
much more flexible and dynamic system that allows much more control.

# How does it work?

This version of OTServ is targeted towards Tibia 7.72.

You have to execute some sql queries from schema.sql.
And check it out. Once you are done, have a look around in the folders
and take a look at the config.lua

NEVER ever enter your real acc# and/or password when not connecting to the CIP servers.
Then you are logged in.


# Contributors

- Currently active:

    - scopp - Nosgia Server

- Inactive Developers
    - Acrimon - Initial project developer
    - Aire - Developer
    - Anstice - Developer
    - Arkold Thos - Linux porter
    - assassina - OpenTibia
    - bruno - ODBC driver
    - Decar - Fansite
    - Fandoras - Developer
    - GriZzm0 - Scripting
    - hackerpotato - OpenTibia
    - Haktivex - Developer
    - Heliton - Scripting
    - iryont - OpenTibia
    - j4K3xBl4sT3r - Developer
    - Jiddo - Scripting
    - marksamman - OpenTibia
    - Matkus - Developer
    - Nostradamus - Scripting
    - Nuker - Forum administrator
    - Pedro B. - Developer
    - Pekay - README Documentation, Forum administrator
    - Peonso - Tibia Legacy Server & OTHire
    - Primer - Developer
    - Privateer - Documentation on the protocol
    - Reebow - Developer, special protocol support
    - Remere / hjnilsson - Developer
    - Shi'Voc - Initial project developer
    - SimOne / xeroc81 - Developer
    - Smygflik - Developer
    - Snack - Developer
    - Spin - Developer
    - the fike - Developer (advisory/optimization)
    - TiMMit - Developer
    - Tliff - Developer, OpenTibia leader, Forum administrator
    - Torvik - Item list
    - TwistedScorpio - OTHire
    - verkon - Forum administrator
    - Vitor - Developer (advisory/optimization)
    - Winghawk - Item list, Scripts
    - Wrzasq - Developer
    - Yorick - Fansite, Forum administrator
    - Blackdemon
    - Evo
    - FightingElf
    - Gecko
    - kilouco / aseverino
    - Mackan
    - nfries88
    - OsoSangre
    - rafaelhamdan
    - Stormer
    - Tythor Zeth


- Contributors

adakraz, Bennet, Dored, Pietia10, Quintinon, Fusion666, Joffily, Ispiro, slawkens, Umby, Rogier1337, pajlada,
Fernando Coutinho, Sapphire, Lithium, Proglin, LooS!k, Jason, nicaw, Xidaozu, The Chaos, Junkfood,
Beet Da Brat, honux, Ruly, Steeled Blade, Xera, BurnMc, Cayan, BlackKnight, Thomac, mike2k1, SuperGillis,
wik, Tijn, _X_Dead_X_, Skulldiggers, NeWsOfTzzz, kijano, Rex, DimiGhost, dark-bart, DeathClaw, Steelberg, Jero,
TechnoPirate, Mozila, Thax, Ashganek, RicarDog, ZeroCoolz, K-Zodron, gerax, Urmel, Cip, wasabi, Jovial, Yurez,
Rebell, Ilidian, blaxskull, dabobath, Mindrage, Eventide, MedionAktiver, Czepek, krt, mmb, Iyashii, Mazen, Figgi, 
Rith, Rizz, Vinny, YobaK, Nexoz, Ferrus

And special thanks to all otfans.net moderators.

Note that only websites mentioned in this document are treated as official support of OTServ.

No other websites are officialy affiliated with OTServ.

# Anything else
Yes! There are utilities available as a seperate projects under the opentibia organization

This includes an IP changer, a remote administration tool, an item editor and more.

# Eclipse (Linux)
If you are willing to use Eclipse in Linux, remember to set the required libraries in:
Project properties -> C/C++ General -> Paths and Symbols

The libraries you have to set are:
/usr/include/libxml2
/usr/include/lua5.1