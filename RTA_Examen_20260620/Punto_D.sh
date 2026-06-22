#!/bin/bash
cd ~/UTN-FRA_SO_Examenes/202406/ansible/
cat << 'FIN1' > roles/2do_parcial/vars/main.yml
nombre_alumno: "Nahuel"
apellido_alumnos: "Gomez"
division_alumno: "115"
FIN1
cat << 'FIN2' > roles/2do_parcial/templates/datos_alumno.j2
Nombre: {{ nombre_alumno }} Apellido: {{ apellido_alumno }}
Division: {{ division_alumno }}
FIN2
cat << 'FIN3' > roles/2do_parcial/templates/datos_equipo.j2
IP: {{ ansible_default_ipv4.address }}
Distribucion: {{ ansible_facts['distribution'] }}
Cantidad de Cores: {{ ansible_processor_vcpus }}
FIN3
cat << 'FIN4' > roles/2do_parcial/tasks/main.yml
- name: "Crear estructura de directorios"
  file:
    path: "{{ item }}"
    state: directory
    mode: '0775'
  with_items:
    - "/tmp/2do_parcial/alumno"
    - "/tmp/2do_parcial/equipo"
- name: "Generar archivo de datos del alumno"
  template:
    src: "datos_alumno.j2"
    dest: "/tmp/2do_parcial/alumno/datos_alumno.txt"
- name: "Generar archivo de datos del equipo"
  template:
    src: "datos_equipo.j2"
    dest: "/tmp/2do_parcial/equipo/datos_equipo.txt"
- name: "Configurar sudoers para el grupo 2PSupervisores"
  become: yes
  copy:
    content: "%2PSupervisores ALL=(ALL) NOPASSWD:ALL"
    dest: "/etc/sudoers.d/2PSupervisores"
    validate: '/usr/sbin/visudo -cf %s'
FIN4
ansible-playbook -i inventory playbook.yml
