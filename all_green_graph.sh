#!/bin/bash
echo "Creating completely green but realistic contribution graph..."

# Verify config
echo "Using: $(git config user.name) <$(git config user.email)>"

# Years to cover
START_YEAR=2019
END_YEAR=2025

# Loop through every single day from 2019 to 2025
current_date="$START_YEAR-01-01"
end_date="$END_YEAR-12-31"

echo "Generating commits from $current_date to $end_date..."

while [[ "$current_date" < "$end_date" ]] || [[ "$current_date" == "$end_date" ]]; do
    # Random number of commits per day (1-4 to make it look natural)
    # Some days have more commits (darker green), some have fewer
    daily_commits=$((1 + RANDOM % 4))
    
    for ((commit_num=1; commit_num<=daily_commits; commit_num++)); do
        # Different commit times throughout the day
        hour=$((9 + RANDOM % 8))  # Between 9 AM - 5 PM
        minute=$((RANDOM % 60))
        commit_time=$(printf "%02d:%02d:00" $hour $minute)
        
        # Create commit with realistic message types
        commit_messages=(
            "feat: add new feature"
            "fix: resolve issue" 
            "refactor: improve code structure"
            "docs: update documentation"
            "style: format code"
            "test: add test cases"
            "chore: maintenance tasks"
        )
        
        message_index=$((RANDOM % ${#commit_messages[@]}))
        commit_message="${commit_messages[$message_index]}"
        
        # Make the change
        echo "Work on $current_date - Commit $commit_num" >> project_log.txt
        git add .
        
        # Commit with specific date/time
        GIT_COMMITTER_DATE="$current_date $commit_time" git commit -m "$commit_message - $current_date" --date="$current_date $commit_time" --no-edit
        
        echo "✓ $current_date: $commit_message"
    done
    
    # Move to next day (with occasional 1-2 day gaps to look more natural)
    gap=$((1 + RANDOM % 3))  # 1-3 day gaps occasionally
    current_date=$(date -d "$current_date + $gap days" "+%Y-%m-%d")
    
    # Progress indicator
    if [[ $(date -d "$current_date" +%m%d) == "0101" ]]; then
        year=$(date -d "$current_date" +%Y)
        echo "--- Completed year: $year ---"
    fi
done

echo "Pushing all commits to GitHub..."
git push origin main

echo ""
echo "🎉 ALL DONE! Your graph should be completely green!"
echo "📊 Years covered: 2019-2025"
echo "⏰ Wait a few hours for GitHub to update your graph"
