FROM python:3.7.3

USER root

#==================================
# Set Workdir
#==================================
RUN mkdir /home/robot
WORKDIR /home/robot

#=========================================
# Install python3 packages
#=========================================
RUN pip install -U \
    robotframework==3.2a1 \
    allure-robotframework==2.6.3 \
    robotframework-imaplibrary==0.3.0 \
    robotframework-requests==0.5.0 \
    robotframework-seleniumlibrary==4.1.0 \
    robotframework-sshlibrary==3.3.0 \
    requests==2.22.0 \
    jsonref==0.2 \
    jsonschema==3.0.1 \
    docker==4.0.1 \
    hashids==1.2.0 \
    coloredlogs==10.0 \
    StringGenerator==0.3.3 \
    PyYAML==5.1 \
    paramiko==2.6.0 \
    pyminizip==0.2.4 \
    workalendar==6.0.0

#==================================
# Install Library
#==================================
RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get install -y unzip openjdk-8-jre-headless xvfb libxi6 libgconf-2-4 bash && \
    apt-get install -y locales && \
    locale-gen zh_TW zh_TW.UTF-8

#==================================
# Set UI Setting
#==================================
    # Install Chrome
RUN apt-get install -y fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libgtk-3-0 lsb-release xdg-utils && \
    wget -O /tmp/chrome.deb https://www.slimjet.com/chrome/download-chrome.php?file=files%2F69.0.3497.92%2Fgoogle-chrome-stable_current_amd64.deb && \
    dpkg -i /tmp/chrome.deb || true && \
    # Install ChromeDriver
    wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/2.44/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip chromedriver && \
    rm /tmp/chromedriver.zip && \
    sudo mv -f chromedriver /usr/local/bin/chromedriver && \
    sudo chown root:root /usr/local/bin/chromedriver && \
    sudo chmod 0755 /usr/local/bin/chromedriver && \
    sudo mv /usr/local/bin/chromedriver /usr/local/bin/chromedriver_2.44

ENV LANG zh_TW.UTF-8
ENV LANGUAGE zh_TW:zh
ENV LC_ALL zh_TW.UTF-8

#==================================
# Set Jenkins User
#==================================
RUN useradd -m -s /bin/bash --uid 1001 -G root jenkins && \
    echo "jenkins ALL=(ALL) NOPASSWD: /bin/chmod" >> /etc/sudoers && \
    /bin/chown -R jenkins /home/robot

USER jenkins
RUN sudo chmod 2777 /home/robot
CMD sh
