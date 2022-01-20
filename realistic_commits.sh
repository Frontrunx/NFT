#!/bin/bash
echo "Creating realistic random commits from 2019-2025..."

# Create initial commit if needed
echo "Initial commit" > commit_history.txt
git add commit_history.txt
git commit -m "Initial commit" --no-edit

for i in {1..500}; do
    # Generate random year between 2019-2025
    year=$((2019 + RANDOM % 7))
    
    # Generate random month (1-12)
    month=$((1 + RANDOM % 12))
    
    # Generate random day (1-28 to avoid month issues)
    day=$((1 + RANDOM % 28))
    
    # Generate random time
    hour=$((RANDOM % 24))
    minute=$((RANDOM % 60))
    second=$((RANDOM % 60))
    
    # Format the date properly
    commit_date=$(printf "%d-%02d-%02d %02d:%02d:%02d" $year $month $day $hour $minute $second)
    
    # Add unique content
    echo "Commit $i - Random data: $(openssl rand -base64 12) - Date: $commit_date" >> commit_history.txt
    
    # Stage and commit
    git add commit_history.txt
    GIT_COMMITTER_DATE="$commit_date" git commit -m "Update: Commit $i - $year" --date="$commit_date" --no-edit
    
    echo "Created commit $i for date: $commit_date"
    
    # Small delay to avoid rate limiting
    sleep 1
done

echo "Pushing all commits to GitHub..."
git push origin main
echo "Done! Check your GitHub profile in a few hours."
