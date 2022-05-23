# get time stamp
time=$(date "+%Y-%m-%d")
time_date=$(date "+%Y-%m-%d %H:%M:%S")
echo "${time}"

# enter directory
cd ./x423xu.github.io/_posts/

# makefile with time stamp
read -p "Enter file name: " name
read -p "Enter your post title: " title
file_name="${time}-${name}.md"
echo "${file_name}"
touch ${file_name}

# write front page
> ${file_name}
echo "---" >> ${file_name}
echo "layout: post_layout" >> ${file_name}
echo "title: ${title}" >> ${file_name}
echo "time: ${time_date}" >> ${file_name}
echo "---" >> ${file_name}
