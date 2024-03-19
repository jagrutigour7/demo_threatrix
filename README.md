# Threatrix Orb

## Introduction

The Threatrix Private Orb is a specialized tool designed to seamlessly integrate security scanning capabilities into your CI/CD pipelines. By utilizing this private orb, teams can efficiently scan their codebases for vulnerabilities and track them within the Threatrix dashboard, ensuring comprehensive security assessments and proactive risk mitigation throughout the software development process.

## Prerequisites

### 1. Create an Account on Threatrix
The easiest way to scan your project is by authenticating using GitHub or GitLab. This enables you to have immediate access to your projects.

### 2. Generate API Key, Entity ID, and Organization ID 
- Navigate to Settings > User > API Keys.
  - Select Add API key and provide all the necessary information to generate the API key.
- Go to Settings > User > Entities.
  - Here you can find the Entity ID and Organization ID.

Store all these three values as they will be required for scanning.

## Overview of Threatrix Private Orb

Added a private orb for Threatrix in `test-deploy.yml`.

```yaml
version: 2.1
orbs:
  # Orb for CircleCI utility commands and workflows.
  orb-tools: circleci/orb-tools@12.0
  # Private orb for integrating with the Threatrix security platform.
  demo_threatrix: theatrix/demo_threatrix@dev:alpha
```

Under workflow define threatrix job and all the required perameters for scanning

``` yml
workflows: # a single workflow with a single job called test-deploy
  test-deploy:
    jobs:
      - demo_threatrix/install_and_scan_code:
          oid: threatrix_oid
          eid: threatrix_eid
          api_key: threatrix_api_key
          dir: ./
          filters: *filters
          context: threatrix
```

### Jobs


This CircleCI job installs the Threatrix Threat Agent and initiates code scanning. It utilizes provided parameters like Organization ID, Entity ID, API Key, and directory path for scanning, ensuring seamless integration into CI/CD pipelines.

### Commands

This YAML configuration defines a CircleCI job for installing and utilizing the Threatrix Threat Agent for code scanning purposes. The job takes parameters including Organization ID, Entity ID, API Key, and directory path for code scanning. It executes a Bash script <b>install_and_scan_code.sh</b> with the provided parameters, facilitating the streamlined deployment and operation of the Threat Agent within CI/CD pipelines for continuous security monitoring.

### Scripts

This Bash script automates the installation and execution of the Threatrix Threat Agent. It downloads the latest Threat Agent binary from the official repository, executes it with specified parameters such as Organization ID, Environment ID, API key, and directory to be scanned, providing streamlined setup for continuous threat monitoring.

### executors

This configuration sets up a Java Docker image for Threatrix operations, allowing customization of the Node version through the tag parameter.

## How to Use Threatrix private orb

Generate a .circleci/config.yml file in your repository that needs to be scanned.

Now in that file, add the following block:

``` yml
version: 2.1
setup: true
orbs:
  demo_threatrix: theatrix/demo_threatrix@dev:alpha

filters: &filters
  tags:
    only: /.*/

workflows:
  install-and-run-threatrix:
    jobs:
      - demo_threatrix/install_and_scan_code:
          oid: THREATRIX_OID
          eid: THREATRIX_EID
          api_key: THREATRIX_API_KEY
          dir: <path_to_directory>
```
Replace  Threatrix Organization ID with THREATRIX_OID, Entity ID with THREATRIX_EID and API_KEY with THREATRIX_APY_KEY 

After successful execution of pipeline a report will be visible on threatrix dashboard

### How to Publish An Update

1. Merge pull requests with desired changes to the main branch.
    - For the best experience, squash-and-merge and use [Conventional Commit Messages](https://conventionalcommits.org/).
2. Find the current version of the orb.
    - You can run `circleci orb info theatrix/demo_threatrix | grep "Latest"` to see the current version.
3. Create a [new Release](https://github.com/jagrutigour7/demo_threatrix/releases/new) on GitHub.
    - Click "Choose a tag" and _create_ a new [semantically versioned](http://semver.org/) tag. (ex: v1.0.0)
      - We will have an opportunity to change this before we publish if needed after the next step.
4.  Click _"+ Auto-generate release notes"_.
    - This will create a summary of all of the merged pull requests since the previous release.
    - If you have used _[Conventional Commit Messages](https://conventionalcommits.org/)_ it will be easy to determine what types of changes were made, allowing you to ensure the correct version tag is being published.
5. Now ensure the version tag selected is semantically accurate based on the changes included.
6. Click _"Publish Release"_.
    - This will push a new tag and trigger your publishing pipeline on CircleCI.