#!/bin/bash
echo "Filling missing years: 2022, 2023, 2024..."

# Verify config
echo "Using: $(git config user.name) <$(git config user.email)>"

# Focus on the missing years
years=(2022 2023 2024)

for year in "${years[@]}"; do
    echo "=== Processing year: $year ==="
    
    # Start from January 1st of the year
    current_date="$year-01-01"
    end_date="$year-12-31"
    
    while [[ "$current_date" < "$end_date" ]] || [[ "$current_date" == "$end_date" ]]; do
        # 1-3 commits per day for these years
        daily_commits=$((1 + RANDOM % 3))
        
        for ((commit_num=1; commit_num<=daily_commits; commit_num++)); do
            hour=$((9 + RANDOM % 8))
            minute=$((RANDOM % 60))
            commit_time=$(printf "%02d:%02d:00" $hour $minute)
            
            # Realistic commit messages
            commit_messages=(
                "feat: enhance functionality"
                "fix: bug resolution"
                "refactor: code optimization"
                "docs: update readme"
                "test: add coverage"
                "chore: dependency update"
            )
            
            message_index=$((RANDOM % ${#commit_messages[@]}))
            commit_message="${commit_messages[$message_index]}"
            
            # Make the change
            echo "Development $current_date - Commit $commit_num" >> project_development.txt
            git add .
            
            # Commit with specific date/time
            GIT_COMMITTER_DATE="$current_date $commit_time" git commit -m "$commit_message - $year" --date="$current_date $commit_time" --no-edit
            
            echo "✓ $current_date: $commit_message"
        done
        
        # Move to next day (with occasional gaps)
        gap=$((1 + RANDOM % 2))
        current_date=$(date -d "$current_date + $gap days" "+%Y-%m-%d")
    done
    
    echo "--- Completed year: $year ---"
done

echo "Pushing new commits to GitHub..."
git push origin main

echo ""
echo "✅ Added commits for 2022, 2023, 2024!"
echo "📈 Your graph will now be complete across all years"
