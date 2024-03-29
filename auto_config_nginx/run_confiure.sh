echo "------------CONFIGURE SERVER--------------"
echo "Name your domain website"
read domain_name 

export path_file_index="\/var\/www\/html"
export ip_address="127.0.0.1"
export port_container="80"
export index_file="index.html"

while [ true ];
do
  echo "Your server is at LOCAL or REMOTE"
  echo "1. Local"
  echo "2. Remote"
  read locate_server

  if [[ $locate_server == 1 ]]; then
    while [ true ];
    do
      echo "--------------------------------------"
      echo "Do your project run on LOCAL FILE or DOCKER"
      echo "1. Local file"
      echo "2. Docker"
      read envir

      if [[ $envir == 1 ]]; then
          break
      else
        if [[ $envir == 2 ]]; then
          break
        else
          echo "--------------------------------------"
          echo "!!!!! Invalid choice. Please retype. !!!!!"
        fi
      fi

    done  
    break
  else
    if [[ $locate_server == 2 ]]; then
      while [ true ];
      do
        echo "--------------------------------------"
        echo "Do your project run on LOCAL FILE or DOCKER"
        echo "1. Local file"
        echo "2. Docker"
        read envir

        if [[ $envir == 1 ]]; then
            break
        else
          if [[ $envir == 2 ]]; then
            break
          else
            echo "--------------------------------------"
            echo "!!!!! Invalid choice. Please retype. !!!!!"
          fi
        fi

      done  
      break
    else
      echo "------------------------------"
      echo "!!!!! Invalid choice. Please retype. !!!!!"
    fi
  fi

done  

#locate_server = 1  -> Local Server
if [[ $locate_server == 1 ]] 
then
  echo "---------------Local Server-------------------"
  #envir = 1  -> Local
  if [[ $envir == 1 ]]
  then
    echo "Enter path that contain index file, format(/var/www/html = \\\/var\\\/www\\\/html)"
    echo "Enter to default /etc/www/html"
    read path_file_index
    echo "Name of index file (Enter to defaul index.html)"
    read index_file

    #Configure file sp_local_server_file_cfg
    cp ./source_file_configure/sp_local_server_file_cfg file_configure
    cp ./source_file_configure/sp_configure_nginx.yml configure_nginx.yml

  else
    echo "Enter port of container"
    read port_container

    #Configure file sp_docker_cfg
    cp ./source_file_configure/sp_docker_cfg file_configure
    cp ./source_file_configure/sp_configure_nginx.yml configure_nginx.yml

  fi
else
  #locate_server = 2  -> Remote Server
  echo "---------------Remote Server-------------------"
  echo "Enter IP your server: "
  read ip_address
  if [[ $envir == 1 ]]
  then
    echo "Enter path that contain index file, format(/var/www/html = \\\/var\\\/www\\\/html)"
    echo "Enter to default /etc/www/html"
    read path_file_index
    echo "Name of index file (Enter to default index.html)"
    read index_file

    #Configure file sp_remote_server_file_cfg
    cp ./source_file_configure/sp_remote_server_file_cfg file_configure
    cp ./source_file_configure/sp_configure_nginx.yml configure_nginx.yml

  else
    echo "Enter port of container"
    read port_container

    #Configure file sp_docker_cfg
    cp ./source_file_configure/sp_docker_cfg file_configure
    cp ./source_file_configure/sp_configure_nginx.yml configure_nginx.yml

  fi
fi

if [[ $index_file == '' ]]; then
  export index_file="index.html"
fi

if [[ $path_file_index == '' ]]; then
  export path_file_index="\/var\/www\/html"
fi

sed -i "s/domain_name/$domain_name/g" file_configure
sed -i "s/ip_address/$ip_address/g" file_configure
sed -i "s/path_file_index/$path_file_index/g" file_configure
sed -i "s/index_file/$index_file/g" file_configure
sed -i "s/port_container/$port_container/g" file_configure
sed -i "s/domain_name/$domain_name/g" configure_nginx.yml


ansible-playbook configure_nginx.yml -e "ansible_become_password=67"


