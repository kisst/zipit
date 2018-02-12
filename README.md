# HOWTO

#### Basics

This few helper script should let you to build prepackaged **lambda** packages in a zip format, with the system, and pip dependencies for **python** scripts.

#### Notes

 - This version use **python 3.6**
 - The name of the folder where this files are will be the name of the zip
 - The name of the folder also should be the python script name
 - Tested on **Linux** only, but should work on OSX
 - This script does not use venv
 - This script does use amazonlinux **docker** image

#### How to use it

1) Create a folder structure like this
```
ses_route53_verification/
├── build.sh
├── init.sh
├── pip-requirements.txt
├── ses_route53_verification.py
└── system-requirements.txt
```

2) Fill up the `pip-requirements.txt` and the `system-requirements.txt` based on your script imports.

3) Run the `./init.sh`

That should be it, you should have a new zip in your folder.

If you have trouble then let me know, create a ticket, send a PR whatever.

