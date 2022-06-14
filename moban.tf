
{
  "ROSTemplateFormatVersion": "2015-09-01",
  "Description": {
    "zh-cn": "在1个ECS实例上部署 LNMP（Linux+Nginx+MySQL+PHP）堆栈；模板仅支持 CentOS-7。",
    "en": "Deploy LNMP(Linux+Nginx+MySQL+PHP) stack on 1 ECS instance. *** WARNING *** Only support CentOS-7."
  },
  "Parameters": {
    "SystemDiskCategory": {
      "Default": "cloud_ssd",
      "Label": {
        "zh-cn": "系统磁盘类型",
        "en": "System Disk Category"
      },
      "Type": "String",
      "Description": {
        "zh-cn": "<font color='blue'><b>可选值：</b></font><br>[cloud_efficiency: <font color='green'>高效云盘</font>]<br>[cloud_ssd: <font color='green'>SSD云盘</font>]<br>[cloud_essd: <font color='green'>ESSD云盘</font>]<br>[cloud: <font color='green'>普通云盘</font>]<br>[ephemeral_ssd: <font color='green'>本地SSD盘</font>]",
        "en": "<font color='blue'><b>Optional values:</b></font><br>[cloud_efficiency: <font color='green'>Efficient Cloud Disk</font>]<br>[cloud_ssd: <font color='green'>SSD Cloud Disk</font>]<br>[cloud_essd: <font color='green'>ESSD Cloud Disk</font>]<br>[cloud: <font color='green'>Cloud Disk</font>]<br>[ephemeral_ssd: <font color='green'>Local SSD Cloud Disk</font>]"
      },
      "AllowedValues": [
        "cloud_efficiency",
        "cloud_ssd",
        "cloud",
        "cloud_essd",
        "ephemeral_ssd"
      ]
    },
    "InstancePassword": {
      "Type": "String",
      "Description": {
        "zh-cn": "长度8-30，必须包含大写字母、小写字母、数字、特殊符号三个；<br>特殊字符包括：()`~!@#$%^&*_-+=|{}[]:;'<>,.?/",
        "en": "The 8-30 long login password of instance, consists of the uppercase, lowercase letter and number. <br> special characters include()`~!@#$%^&*_-+=|{}[]:;'<>,.?/"
      },
      "MinLength": "8",
      "Label": {
        "zh-cn": "实例密码",
        "en": "Instance Password"
      },
      "AllowedPattern": "[0-9A-Za-z\\_\\-&:;'<>,=%`~!@#\\(\\)\\$\\^\\*\\+\\|\\{\\}\\[\\]\\.\\?\\/]+$",
      "NoEcho": true,
      "MaxLength": "30",
      "ConstraintDescription": {
        "zh-cn": "长度8-30，必须包含大写字母、小写字母、数字、特殊符号三种；特殊字符包括：()`~!@#$%^&*_-+=|{}[]:;' <>,.?/",
        "en": "Length 8-30, must contain upper case letters, lower case letters, Numbers, special symbols three; special characters include: ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/"
      }
    },
    "ImageId": {
      "Default": "centos_7",
      "Type": "String",
      "Description": {
        "zh-cn": "服务器镜像，详见：<b><a href='https://help.aliyun.com/document_detail/112977.html' target='_blank'><font color='blue'>查找镜像</font></a></b>",
        "en": "Server instance Image ID. see detail: <b><a href='https://www.alibabacloud.com/help/doc-detail/112977.html' target='_blank'><font color='blue'>Find the mirror</font></a></b>"
      },
      "Label": {
        "zh-cn": "镜像ID",
        "en": "Image ID"
      }
    },
    "DBName": {
      "ConstraintDescription": {
        "zh-cn": "由 2 到 64 个小写字母组成，下划线。必须以字母开头，以字母数字字符结尾",
        "en": "Consist of 2 to 64 characters of lowercase letters, underline. Must begin with a letter and be end with an alphanumeric character"
      },
      "Description": {
        "zh-cn": "MySQL数据库名称，[1, 64] 英文或中文字符，必须以字母或中文开头，可以包含数字、下划线或“.”、“-”。",
        "en": "MySQL database name, [1, 64] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'."
      },
      "Default": "MyDatabase",
      "MinLength": 1,
      "Label": {
        "zh-cn": "数据库名称",
        "en": "DB Name"
      },
      "MaxLength": 64,
      "Type": "String"
    },
    "DBPassword": {
      "Type": "String",
      "Description": {
        "zh-cn": "MySQL密码，数据库访问大小写字母、数字和下划线（_），8-32个字符",
        "en": "The MySQL password, consisting of letters, numbers, and underline(_), 8 to 32 characters in length"
      },
      "MinLength": 8,
      "Label": {
        "zh-cn": "数据库密码",
        "en": "DB Password"
      },
      "NoEcho": true,
      "MaxLength": 32,
      "ConstraintDescription": {
        "zh-cn": "[8, 32] 个字符由字母数字字符、连字符和下划线组成",
        "en": "[8, 32] characters consist of alphanumeric characters, hyphen and underline"
      }
    },
    "DBUser": {
      "ConstraintDescription": {
        "zh-cn": "由 2 到 16 个小写字母组成，下划线。必须以字母开头，以字母数字字符结尾",
        "en": "Consist of 2 to 16 characters of lowercase letters, underline. Must begin with a letter and be end with an alphanumeric character"
      },
      "Description": {
        "zh-cn": "MySQL数据库访问的用户名。它由小写字母、数字和下划线（_）组成，以字母开头。不超过16个字符。",
        "en": "Username for MySQL database access.It consists of lowercase letters, numbers and underscores (_), and begins with a letter. Not longer than 16 characters."
      },
      "Default": "DefaultUser",
      "MinLength": 2,
      "Label": {
        "zh-cn": "数据库用户名",
        "en": "DB Username"
      },
      "MaxLength": 16,
      "Type": "String"
    },
    "DBRootPassword": {
      "Type": "String",
      "Description": {
        "zh-cn": "MySQL的root密码, 由字母、数字、下划线（_）组成，长度为8~32个字符",
        "en": "Root password for MySQL, consisting of letters, numbers, and underline(_), 8 to 32 characters in length"
      },
      "MinLength": 8,
      "Label": {
        "zh-cn": "数据库root用户密码",
        "en": "DB Root Password"
      },
      "NoEcho": true,
      "MaxLength": 32,
      "ConstraintDescription": {
        "zh-cn": "由字母、数字和下划线(_)组成，长度为8到32个字符",
        "en": "Consisting of letters, numbers, and underline(_), 8 to 32 characters in length"
      }
    },
    "InstanceType": {
      "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
      "AssociationPropertyMetadata": {
        "ZoneId": "ZoneId"
      },
      "Type": "String",
      "Description": {
        "zh-cn": "填写可用区下可使用的规格；<br>通用规格：<font color='red'><b>ecs.c5.large</b></font><br>注：可用区可能不支持通用规格<br>规格详见：<a href='https://help.aliyun.com/document_detail/25378.html' target='_blank'><b><font color='blue'>实例规格族</font></a></b>",
        "en": "Fill in specifications that can be used under availability zone;</b></font><br>general specifications：<font color='red'><b>ecs.c5.large</b></font><br>note: a few zones do not support general specifications<br>see detail: <a href='https://www.alibabacloud.com/help/en/doc-detail/25378.html' target='_blank'><b><font color='blue'>Instance Specification Family</font></a></b>"
      },
      "Label": {
        "zh-cn": "实例类型",
        "en": "Instance Type"
      }
    },
    "ZoneId": {
      "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",
      "Type": "String",
      "Description": {
        "zh-cn": "可用区ID。<br><b>注： <font color='blue'>选择可用区前请确认该可用区是否支持创建ECS资源的规格</font></b>",
        "en": "Availability Zone ID,<br><b>note： <font color='blue'>Before selecting, please confirm that the Availability Zone supports the specification of creating ECS resources</font></b>"
      },
      "Label": {
        "zh-cn": "可用区ID",
        "en": "Available Zone ID"
      }
    },
    "NginxDownloadUrl": {
      "Default": "http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm",
      "Type": "String",
      "Description": {
        "zh-cn": "nginx-*.rpm源下载路径",
        "en": "nginx-.rpm source download path."
      },
      "Label": {
        "zh-cn": "Nginx源",
        "en": "Nginx Source"
      }
    }
  },
  "Outputs": {
    "NginxWebsiteURL": {
      "Description": "URL for newly created Nginx home page.",
      "Value": {
        "Fn::Join": [
          "",
          [
            "http://",
            {
              "Fn::GetAtt": [
                "WebServer",
                "PublicIp"
              ]
            },
            ":80/test.php"
          ]
        ]
      }
    }
  },
  "Resources": {
    "EcsSecurityGroup": {
      "Type": "ALIYUN::ECS::SecurityGroup",
      "Properties": {
        "SecurityGroupIngress": [
          {
            "Priority": 1,
            "PortRange": "-1/-1",
            "NicType": "intranet",
            "SourceCidrIp": "0.0.0.0/0",
            "IpProtocol": "all"
          }
        ],
        "VpcId": {
          "Ref": "EcsVpc"
        },
        "SecurityGroupEgress": [
          {
            "Priority": 1,
            "PortRange": "-1/-1",
            "IpProtocol": "all",
            "NicType": "intranet",
            "DestCidrIp": "0.0.0.0/0"
          }
        ]
      },
      "Metadata": {
        "ALIYUN::ROS::Designer": {
          "id": "7a621d9a-c803-4121-ba09-30dc9a417423"
        }
      }
    },
    "WebServerConditionHandle": {
      "Type": "ALIYUN::ROS::WaitConditionHandle",
      "Metadata": {
        "ALIYUN::ROS::Designer": {
          "id": "ec1625d7-b79b-496d-ba3a-5c46be0c1181"
        }
      }
    },
    "EcsVSwitch": {
      "Type": "ALIYUN::ECS::VSwitch",
      "Properties": {
        "VpcId": {
          "Ref": "EcsVpc"
        },
        "CidrBlock": "192.168.1.0/24",
        "ZoneId": {
          "Ref": "ZoneId"
        }
      },
      "Metadata": {
        "ALIYUN::ROS::Designer": {
          "id": "dae2dd74-1b30-4975-8b70-4877f4c2d9d3"
        }
      }
    },
    "WebServer": {
      "Type": "ALIYUN::ECS::Instance",
      "Properties": {
        "UserData": {
          "Fn::Replace": [
            {
              "ros-notify": {
                "Fn::GetAtt": [
                  "WebServerConditionHandle",
                  "CurlCli"
                ]
              }
            },
            {
              "Fn::Join": [
                "",
                [
                  "#!/bin/bash \n",
                  "NginxUrl=",
                  {
                    "Ref": "NginxDownloadUrl"
                  },
                  "\n",
                  "dbname=",
                  {
                    "Ref": "DBName"
                  },
                  "\n",
                  "dbuser=",
                  {
                    "Ref": "DBUser"
                  },
                  "\n",
                  "dbpassword=",
                  {
                    "Ref": "DBPassword"
                  },
                  "\n",
                  "dbrootpassword=",
                  {
                    "Ref": "DBRootPassword"
                  },
                  "\n",
                  "export HOME=/root \n",
                  "export HOSTNAME=`hostname` \n",
                  "systemctl stop firewalld.service \n",
                  "systemctl disable firewalld.service \n",
                  "sed -i 's/^SELINUX=/# SELINUX=/' /etc/selinux/config \n",
                  "sed -i '/# SELINUX=/a SELINUX=disabled' /etc/selinux/config \n",
                  "setenforce 0 \n",
                  "yum install yum-priorities -y \n",
                  "yum -y install aria2 \n",
                  "aria2c $NginxUrl \n",
                  "rpm -ivh nginx-*.rpm \n",
                  "yum -y install nginx \n",
                  "systemctl start nginx.service \n",
                  "systemctl enable nginx.service \n",
                  "yum -y install php-fpm \n",
                  "systemctl start php-fpm.service \n",
                  "systemctl enable php-fpm.service \n",
                  "sed -i '/FastCGI/,/htaccess/s/    #/    /' /etc/nginx/conf.d/default.conf \n",
                  "sed -i '/FastCGI/s/^    /    #/' /etc/nginx/conf.d/default.conf \n",
                  "sed -i '/htaccess/s/^    /    #/' /etc/nginx/conf.d/default.conf \n",
                  "sed -i '/SCRIPT_FILENAME/s/\\/scripts/\\/usr\\/share\\/nginx\\/html\\//' /etc/nginx/conf.d/default.conf \n",
                  "yum -y install mariadb mariadb-server \n",
                  "systemctl start mariadb.service \n",
                  "systemctl enable mariadb.service \n",
                  "yum -y install php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash php-mcrypt \n",
                  "MDSRING=`find / -name mbstring.so` \n",
                  "echo extension=$MDSRING >> /etc/php.ini \n",
                  "systemctl restart mariadb.service \n",
                  "mysqladmin -u root password \"$dbrootpassword\" \n",
                  "$(mysql $dbname -u root --password=\"$dbrootpassword\" >/dev/null 2>&1 </dev/null); (( $? != 0 )) \n",
                  "echo CREATE DATABASE $dbname \\; > /tmp/setup.mysql \n",
                  "echo GRANT ALL ON $dbname.* TO \"$dbuser\"@\"localhost\" IDENTIFIED BY \"'$dbpassword'\" \\; >> /tmp/setup.mysql \n",
                  "mysql -u root --password=\"$dbrootpassword\" < /tmp/setup.mysql \n",
                  "$(mysql $dbname -u root --password=\"$dbrootpassword\" >/dev/null 2>&1 </dev/null); (( $? != 0 )) \n",
                  "cd /root \n",
                  "systemctl restart php-fpm.service \n",
                  "systemctl restart nginx.service \n",
                  "echo \\<?php >  /usr/share/nginx/html/test.php \n",
                  "echo \\$conn=mysql_connect\\(\"'127.0.0.1'\", \"'$dbuser'\", \"'$dbpassword'\"\\)\\; >>  /usr/share/nginx/html/test.php \n",
                  "echo if \\(\\$conn\\){ >>  /usr/share/nginx/html/test.php \n",
                  "echo   echo \\\"LNMP platform connect to mysql is successful\\!\\\"\\; >>  /usr/share/nginx/html/test.php \n",
                  "echo   }else{  >>  /usr/share/nginx/html/test.php \n",
                  "echo echo \\\"LNMP platform connect to mysql is failed\\!\\\"\\;  >>  /usr/share/nginx/html/test.php \n",
                  "echo }  >>  /usr/share/nginx/html/test.php \n",
                  "echo  phpinfo\\(\\)\\;  >>  /usr/share/nginx/html/test.php \n",
                  "echo \\?\\>  >>  /usr/share/nginx/html/test.php \n",
                  "ros-notify -d '{\"data\" : \"Install LNMP stack.\"}'\n"
                ]
              ]
            }
          ]
        },
        "SystemDiskCategory": {
          "Ref": "SystemDiskCategory"
        },
        "VpcId": {
          "Fn::GetAtt": [
            "EcsVpc",
            "VpcId"
          ]
        },
        "SecurityGroupId": {
          "Ref": "EcsSecurityGroup"
        },
        "ImageId": {
          "Ref": "ImageId"
        },
        "InternetMaxBandwidthOut": 80,
        "IoOptimized": "optimized",
        "VSwitchId": {
          "Ref": "EcsVSwitch"
        },
        "Password": {
          "Ref": "InstancePassword"
        },
        "InstanceType": {
          "Ref": "InstanceType"
        }
      },
      "Metadata": {
        "ALIYUN::ROS::Designer": {
          "id": "0af5b81e-0e55-4e6a-ba96-45cf7a730510"
        }
      }
    },
    "WebServerWaitCondition": {
      "DependsOn": "WebServer",
      "Type": "ALIYUN::ROS::WaitCondition",
      "Properties": {
        "Count": 1,
        "Handle": {
          "Ref": "WebServerConditionHandle"
        },
        "Timeout": 1800
      },
      "Metadata": {
        "ALIYUN::ROS::Designer": {
          "id": "b528acf3-d6df-43bd-b17e-a22cd32f72e7"
        }
      }
    },
    "EcsVpc": {
      "Type": "ALIYUN::ECS::VPC",
      "Properties": {
        "CidrBlock": "192.168.0.0/16"
      },
      "Metadata": {
        "ALIYUN::ROS::Designer": {
          "id": "598ced8b-0ba4-40a8-a781-1d48e26ca15f"
        }
      }
    }
  },
  "Metadata": {
    "ALIYUN::ROS::Designer": {
      "dae2dd74-1b30-4975-8b70-4877f4c2d9d3": {
        "embeds": [
          "0af5b81e-0e55-4e6a-ba96-45cf7a730510"
        ],
        "position": {
          "y": 123,
          "x": 347
        },
        "z": 1,
        "size": {
          "width": 122,
          "height": 151
        }
      },
      "a828cca7-7ef3-4441-b51d-1ed7c419ad0d": {
        "source": {
          "id": "b528acf3-d6df-43bd-b17e-a22cd32f72e7"
        },
        "z": 1,
        "target": {
          "id": "ec1625d7-b79b-496d-ba3a-5c46be0c1181"
        }
      },
      "0af5b81e-0e55-4e6a-ba96-45cf7a730510": {
        "position": {
          "y": 163,
          "x": 386
        },
        "z": 2,
        "size": {
          "width": 60,
          "height": 60
        }
      },
      "7a621d9a-c803-4121-ba09-30dc9a417423": {
        "position": {
          "y": 163,
          "x": 229
        },
        "z": 1,
        "size": {
          "width": 60,
          "height": 60
        }
      },
      "598ced8b-0ba4-40a8-a781-1d48e26ca15f": {
        "embeds": [
          "dae2dd74-1b30-4975-8b70-4877f4c2d9d3",
          "7a621d9a-c803-4121-ba09-30dc9a417423"
        ],
        "position": {
          "y": 50,
          "x": 192
        },
        "z": 0,
        "size": {
          "width": 318.0537109375,
          "height": 314
        }
      },
      "05871fb7-6c4d-4dc1-abb9-084ad7c14d1c": {
        "source": {
          "id": "0af5b81e-0e55-4e6a-ba96-45cf7a730510"
        },
        "z": 1,
        "target": {
          "id": "7a621d9a-c803-4121-ba09-30dc9a417423"
        }
      },
      "ec1625d7-b79b-496d-ba3a-5c46be0c1181": {
        "position": {
          "y": 98,
          "x": 567
        },
        "z": 0,
        "size": {
          "width": 60,
          "height": 60
        }
      },
      "b528acf3-d6df-43bd-b17e-a22cd32f72e7": {
        "position": {
          "y": 252,
          "x": 567
        },
        "z": 0,
        "size": {
          "width": 60,
          "height": 60
        }
      }
    },
    "ALIYUN::ROS::Interface": {
      "ParameterGroups": [
        {
          "Parameters": [
            "ZoneId",
            "ImageId",
            "InstanceType",
            "SystemDiskCategory",
            "InstancePassword"
          ],
          "Label": {
            "default": "ECS"
          }
        },
        {
          "Parameters": [
            "DBName",
            "DBUser",
            "DBPassword",
            "DBRootPassword"
          ],
          "Label": {
            "default": "Database"
          }
        },
        {
          "Parameters": [
            "NginxDownloadUrl"
          ],
          "Label": {
            "default": "Nginx"
          }
        }
      ],
      "TemplateTags": [
        "Deploy LNMP(Linux+Nginx+MySQL+PHP) stack on 1 ECS instance."
      ]
    }
  }
}
