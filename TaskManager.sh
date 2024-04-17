#!/bin/bash

function display_menu {

echo "Task Manager:"
echo "1- Add Task"
echo "2- View Tasks"
echo "3- Mark Task Complete"
echo "4- Delete Task"
echo "5- Exit"
echo "Enter Your Choice"
read choice
} 

function add_task {

if [ ! -f tasks.txt ]; then
    touch tasks.txt
fi
		
echo "Enter task description"
task_num=$(wc -l < tasks.txt)
((task_num++))

read task_desc

task_with_num="$task_num. $task_desc"
echo "$task_with_num" >> tasks.txt
echo "Task added successfully!"
}


function view_tasks {
	if [ ! -f tasks.txt ]; then
		echo "No Tasks Found"
	else
	    echo "Tasks:"
            cat tasks.txt

        fi
}

function mark_completed {
 if [ ! -f tasks.txt ]; then
    echo "No tasks found"
    return
 fi
 set -x
 echo "Enter Task number"
 read task_num
 if ! grep  "$task_num" tasks.txt; then
   echo "Task number doesnt exist"
   return
 fi
 set +x
 sed -i "${task_num}s/$/[COMPLETED]/" tasks.txt
 echo "task marked completed"
}


function delete_task {
	if [ ! -f tasks.txt ]; then
  		echo "No tasks found"
  		return
	fi
	
	echo " Enter task number to delete"
        read task_num       

       if ! grep -q "^$task_num" tasks.txt; then
          echo " Task number doesn't exist"
          return
       fi

       sed -i "/^$task_num/d" tasks.txt
       echo "Task deleted successfuly"
}


while true; do
 display_menu
 case $choice in
 1) add_task ;;
 2) view_tasks ;;
 3) mark_completed ;;
 4) delete_task ;;
 5) exit 0 ;;
 *) echo "Invalid choice!" ;;
 esac
done 
