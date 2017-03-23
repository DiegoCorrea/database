sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"  
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"  
bin/voltdb start  