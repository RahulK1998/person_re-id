Directory for scheduling video capture on Foscam devices

Dependencies:
  - URL stream must be open in local browser for vid_capture to correctly record stream
  - Run in venv using the command 'source venv/bin/activate' from home directory
  - Python imports/other installs needed
  
*foscam_integrated_v1.py does not work yet*  
  
For foscam_scheduler_v1.py:
  - Usage: python foscam_scheduler_v1.py username password ip date time duration
    - Optional: putting '& disown' at the end pushes the process to the background
    - Desktop notification pops up on when capture begins
      
For foscam_vid_capture_v1.py: 
