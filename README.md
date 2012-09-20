Description
===========

Checks out the pk repo from GitHub and the Joyent pkgsrc repo
and fixes up the git submodules to point to Joyents GitHub
account where Filip moved them to (pkgsrc-joyent and pkgsrc-wip).

It is recommended that you fork the pk repo on GitHub to your
GitHub account and reference that in the attributes.

Requirements
============

 * Chef
 * Git
 * Internet Access

Attributes
==========

 * pk.pkgsrc_release - git branch used for the pkgsrc release
 * pk.repos.pk - points to the clone I am using
 * pk.repos.pkgsrc - points to Joyent pkgsrc repo

Example JSON:

    {
      'pk': {
        'pkgsrc_release' => 'pkgsrc_2012Q1',
        'repos' => {
          'pk' => 'git://github.com/mamash/pk.git',
          'pkgsrc' => 'git://github.com/joyent/pkgsrc.git'
        }
      }
    }

Usage
=====

