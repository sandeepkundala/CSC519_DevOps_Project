## Checkpoint 1
#### Tasks implemented in checkpoint 1 of Milestone 2:

- Made changes to the `pipeline setup` command such that it accepts the --gh-user <username> and --gh-pass <password> as parameters that can be used in cloning the iTrust repository in a later phase.
- Installed maven and mysql using ansible scripts for as prerequisites for iTrust app to run. 
- Tried to run the maven build commands given in the project document and rectified all the tests to pass.
- It required the installation of Google chrome and setting up of timezone, which we set using ansible.
- We have worked on the Static Analysis part of the project and extended the checkbox.io build to incorporate the same.
- Further we ran the iTrust app, and saw that the web page is loading.
- Discussed the "making of a test suite analysis to analyse useful tests" and how to use fuzzing to achieve the same.

#### Further work for Milestone 2:

- Refine and improve playbook written for build command, and also try to remove any shell commands in the current ansible play books.
- Complete the "making of a test suite analysis to analyse useful tests" part of Milestone2.
- Use jenkins npm to trigger the build job instead of Jenkins CLI.
- Working, on the implementation of fuzzing and test prioritization analysis.

#### Issues:
https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/issues?utf8=%E2%9C%93&q=is%3Aissue+label%3A%22Milestone+2%22
