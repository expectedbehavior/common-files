# What is this?
The Common Files is a set of computer configuration files. It includes dotfiles along with configuration and tooling for many common things we do at Expected Behavior. It has a complete computer setup process to minimize the time and effort of getting a new computer into an enjoyable state. It's designed to be

- collaborative  - many people are expected to use these configurations
- non-destuctive - you can try these configurations without deleting or destroying anything you've already got
- personalizable - if you like most of these configurations, it's easy to change some deetails to suit you

You are welcome to use and contribute to these common files even if you don't work at Expected Behavior.

# Installing
If you're installing the common files on a fresh computer, download a zip file of this repository to avoid being sucked into a tedious series of MacOS setup prompts that the common files will take care of for you. Otherwise, clone the repository and run

    script/setup

The setup script is idempotent, so it's fine to abort and run it again later.

If you'd like to run only one part of the setup process, you can invoke that script directly. For example, if you'd like to only install the dotfiles

    script/install/dotfiles

# Contributing
This section is about making changes that will improve life for everyone that uses the common files. If you'd like to make your visual bell neon green, please see the personalization section below.

How do you know if the change you want to make is for everyone or just for you? Here are some rules of thumb

- Is it popular? If many people that use the common files are already using it or interested in it, it's probably worth contributing.
- Is it strictly better? Strictly better means it has all the benefits of the current implementation, along with some improvements.
- Is it unobtrusive? If it's not popular or strictly better, it might still be a good contribution. If you won't notice it unless you look for it and it's unlikely to cause conflicts with future changes, lean towards contribution.
- Is it easy to alter or undo? If you're not sure about the above but it's really easy to change again later, consider contributing.

Contributions are made through the PR process common throughout the land. If you don't know what that means, make an issue and we'll get it sorted.

# Personalizing
This section is about making changes only for yourself. Please consider contributing before personalizing the common files. If you've looked at the contribution guidelines and you're still not sure, Some good indicators it should be personal are

- It costs money or requires a subscription to something the company doesn't pay for.
- You've talked to other people about it and nobody has shown any interest.
- It's difficult to undo. If you haven't tried undo-ing, assume it's difficult.
- It enables a neon green visual bell.

If you'd like to personalize your common files, you can do so in the following ways

## Installed Applications
If you'd like to automatically install some software, you can create your own Brewfile that will install anything Homebrew has to offer. It will work just like the other Brewfiles in that directory, but it will only be executed when you run the setup script. To make you own, run this from the root of your common files

    touch .brewfiles/personal.Brewfile.`whoami`

If you have commit access, please check that file in! If you do, you won't lose it and other people will be able to use it for inspiration for their own customizations.

# Improving This README
Ideally, there would be more to this README. You can help by expanding it! Some things to consider

- Should Installation include or link to encouraged-but-not-required computer and information management practices? For example, keeping your shell secrets in an encrypted volume in Dropbox.
- Contributions should explain or link to explanations of where and how to make changes (e.g. where to add a new shell command, how to update the configuration of a specific app, etc)
- Personalization should do the same (e.g. how do I add an environment variable just for myself?)

