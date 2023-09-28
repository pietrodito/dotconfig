/bin/docker run --publish 8888:8787                                                     \
                --name    draft-rstudio-server                                                \
                -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix                  \
                --mount   type=bind,src=$HOME/Comp/rstudio-projects/,dst=/home/rstudio  \
                --detach  rstudio-server-no-login
