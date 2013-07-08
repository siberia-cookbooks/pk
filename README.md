pk Cookbook [![Build Status](https://www.travis-ci.org/siberia-cookbooks/pk.png?branch=master)](https://www.travis-ci.org/siberia-cookbooks/pk)
===============================================================================================================================================

Checks out the pk repo from GitHub and the Joyent pkgsrc repo
and fixes up the git submodules to point to Joyents GitHub
account where Filip moved them to (pkgsrc-joyent and pkgsrc-wip).

It is recommended that you fork the pk repo on GitHub to your
GitHub account and reference that in the attributes.

WARNING: Joyent is no longer using pk and I am the last man standing
using pk.  I am going to look at switching over to pbulk at some
point in the future.

Requirements
------------

 * Chef
 * Git
 * Internet Access

Attributes
----------

e.g.
#### pk::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['pk']['pkgsrc_release']</tt></td>
    <td>String</td>
    <td>git branch used for the pkgsrc release</td>
    <td>false</td>
  </tr>
  <tr>
    <td><tt>['pk']['repos']['pk']</tt></td>
    <td>String</td>
    <td>points to the clone which I am using</td>
    <td>false</td>
  </tr>
  <tr>
    <td><tt>['pk']['repos']['pkgsrc']</tt></td>
    <td>String</td>
    <td>points to the Joyent pkgsrc repo or your fork on GitHub</td>
    <td>false</td>
  </tr>
</table>

Example JSON:

```json
{
  'pk': {
    'pkgsrc_release' => 'pkgsrc_2012Q2',
    'repos' => {
      'pk' => 'git://github.com/mamash/pk.git',
      'pkgsrc' => 'git://github.com/joyent/pkgsrc.git'
    }
  }
}
```

If you have your own forks of pk, pkgsrc, pkgsrc-joyent and/or pkgsrc-wip,
you most likely want to rather refer to your forks by updating the
git submodules on your fork and using git@github.com:yourname/pkgsrc.git
and git@github.com:yourname/pk.git

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------

```
Copyright (c) 2012-2013 Jacques Marneweck. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

Authors:

 * Jacques Marneweck (jacques@powertrip.co.za)
