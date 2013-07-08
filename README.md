pk Cookbook [![Build Status](https://www.travis-ci.org/siberia-cookbooks/pk.png?branch=master)](https://www.travis-ci.org/siberia-cookbooks/pk)
===============================================================================================================================================

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
 * pk.repos.pkgsrc - points to Joyent pkgsrc repo or your fork on GitHub

Example JSON:

    {
      'pk': {
        'pkgsrc_release' => 'pkgsrc_2012Q2',
        'repos' => {
          'pk' => 'git://github.com/mamash/pk.git',
          'pkgsrc' => 'git://github.com/joyent/pkgsrc.git'
        }
      }
    }

If you have your own forks of pk, pkgsrc, pkgsrc-joyent and/or pkgsrc-wip,
you most likely want to rather refer to your forks by updating the
git submodules on your fork and using git@github.com:yourname/pkgsrc.git
and git@github.com:yourname/pk.git

Usage
=====

