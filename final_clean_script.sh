#!/bin/bash
echo "=== Starting with clean config ==="

# Double-check config
echo "Local config:"
git config --local user.name
git config --local user.email

echo "Creating commits..."

# Create commits across all years
for i in {1..30}; do
    year=$((2019 + RANDOM % 7))
    month=$((1 + RANDOM % 12)) 
    day=$((1 + RANDOM % 28))
    commit_date="$year-$month-$day 12:00:00"
    
    echo "Commit $i - $commit_date" >> history.txt
    git add .
    
    GIT_COMMITTER_DATE="$commit_date" git commit -m "update: $year work" --date="$commit_date" --no-edit
    
    echo "Created: $commit_date"
    sleep 1
done

echo "Pushing..."
git push origin main
echo "=== Complete ==="
