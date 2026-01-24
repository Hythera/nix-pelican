> [!Note]
> Nix Pelican is in a very early stage. Because of this, things might break. You can help making it better and improving its functionality by submitting issues or pull requests.

## How to's

### Building the changes

```bash
# Panel
nix build .#pelican.panel

# Wings
nix build .#pelican.wings

```

### Creating a pull request

0. Set up a local version of Nix Pelican to work with:
   1. [Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository) the [Nix Pelican repository](https://github.com/Hythera/nix-pelican).
   1. [Clone the forked repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#cloning-your-forked-repository) into a local `nix-pelican` directory.
   1. [Configure the upstream Nix Pelican repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#configuring-git-to-sync-your-fork-with-the-upstream-repository).

1. Select the appropriate [base branch](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-branches#working-with-branches) for the change, as [described here][branch].
   If in doubt, use `master`.
   This can be changed later by [rebasing][rebase].

2. Create a new Git branch, ideally such that:
   - The name of the branch hints at your change, e.g. `update-hello`.
   - The branch contains the most recent base branch.

   We'll assume the base branch `master` here.

   ```bash
   # Make sure you have the latest changes from upstream Nix Pelican
   git fetch upstream

   # Create and switch to a new branch, based on the base branch in Nix Pelican
   git switch --create update-hello upstream/master
   ```

3. Make your changes in the local Nix Pelican repository and:
   - Test the changes.
   - If necessary, document the changes.

4. Commit your changes using `git commit`.

   Repeat the steps 3-4 as many times as necessary.
   Advance to the next step once all the commits make sense together.
   You can view your commits with `git log`.

5. Push your commits to your fork of Nix Pelican:
   ```
   git push --set-upstream origin HEAD
   ```

   The above command will output a link to directly do the next step:
   ```
   remote: Create a pull request for 'update-hello' on GitHub by visiting:
   remote:      https://github.com/myUser/nix-pelican/pull/new/update-hello
   ```

6. [Create a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request#creating-the-pull-request) from the new branch in your Nix Pelican fork to the upstream Nix Pelican repository.
   Use the branch from step 1 as the PR's base branch.


7. Respond to review comments and potentially to CI failures and merge conflicts by updating the PR.
   Always keep it in a mergeable state.


   - To add new commits, repeat steps 3-4 and push the result:
     ```
     git push
     ```

   - To change existing commits, [rewrite the Git history](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History).
     Useful Git commands for this are `git commit --patch --amend` and `git rebase --interactive`.
     With a rewritten history you need to force-push the commits:
     ```
     git push --force-with-lease
     ```

   - If there are merge conflicts, you will have to [rebase the branch](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) onto the current **base branch**.
     Sometimes this can be done [on GitHub directly](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/keeping-your-pull-request-in-sync-with-the-base-branch#updating-your-pull-request-branch).
     To rebase locally:
     ```
     git fetch upstream
     git rebase upstream/master
     git push --force-with-lease
     ```

     Use the base branch from step 1 instead of `upstream/master`.
