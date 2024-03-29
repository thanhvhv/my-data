export ip="192.168.3.42"
export domain="server-1.com"
export path_file_index="\/var\/www\/html"
export file_index="index.html"

sed -i "s/ip/$ip/" file_configure
sed -i "s/domain/$domain/" file_configure
sed -i "s/path_file_index/$path_file_index/" file_configure
sed -i "s/file_index/$file_index/" file_configure
sed -i "s/name_domain/$domain/" configure_nginx.yml

ansible-playbook configure_nginx.yml -e "ansible_become_password=67"
