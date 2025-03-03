restart_git_history() {
    log_step "Restarting git history"

    # Remove the existing .git directory
    rm -rf .git

    # Initialize a new git repository
    git init -b main

    # Create the initial commit
    git add .
    git commit -m "Initial commit"

    log_success "Git history restarted"
}