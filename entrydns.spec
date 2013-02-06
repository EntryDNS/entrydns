%global _enable_debug_package   0
%global debug_package           %{nil}
%global __os_install_post       /usr/lib/rpm/brp-compress %{nil}
%global entrydns_root           /srv/entrydns
%global entrydns_user           entrydns
%global entrydns_group          entrydns

Name:           entrydns
Version:        0.0.2
Release:        1%{?dist}
Summary:        Free DNS management service for everyone

Group:          Applications/Internet
License:        AGPL
URL:            https://entrydns.net
Source0:        %{name}-%{version}.tar.gz
BuildArch:      x86_64

BuildRequires:  ruby(abi) = 1.9.1
BuildRequires:  rubygems >= 1.8
BuildRequires:  ruby-devel >= 1.9.3
BuildRequires:  mysql-devel >= 5.5
BuildRequires:  rubygems-devel >= 1.8
BuildRequires:  libxml2-devel
BuildRequires:  libxslt-devel
BuildRequires:  mysql-server
Requires:       ruby(abi) = 1.9.1
Requires(post):   systemd
Requires(preun):  systemd
Requires(postun): systemd


%description
EntryDNS delivers a totally free DNS management service for your enjoyment.
Our aim is to provide a friendly and caring, yet powerful service for your
DNS needs.


%prep
%setup -q


%build
cp config/database.mysql.sample.yml config/database.yml
bundle install --without development test
bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile
rm -rf .bundle
bundle install --path vendor/ --without development test assets

# fix wrong sheebang for unicorn
%if 0%{?fedora} >= 17
find vendor/ruby/*/gems -type f -wholename '*/bin/unicorn*' | xargs \
    grep -rl '/this/will/be/overwritten/or/wrapped/anyways/do/not/worry/ruby' | \
    xargs sed -i -e 's|/this/will/be/overwritten/or/wrapped/anyways/do/not/worry/ruby|/usr/bin/env ruby|'
%endif


%install
# clean not required files and directories
rm -rf test doc spec Capfile Gemfile Gemfile.lock Guardfile Rakefile .git \
    .gitignore .rspec .rvmrc vendor/ruby/1.9.1/cache/* config/database.yml

find vendor/ -type f -wholename "*/cache/*.gem" -delete
find . -type f -name ".git*" -delete

install -p -d -m 0755 %{buildroot}%{entrydns_root}
install -p -d -m 0755 %{buildroot}%{entrydns_root}/log
install -p -d -m 0755 %{buildroot}%{entrydns_root}/tmp
cp -R app %{buildroot}%{entrydns_root}
cp -R config %{buildroot}%{entrydns_root}
cp -R db %{buildroot}%{entrydns_root}
cp -R lib %{buildroot}%{entrydns_root}
cp -R public %{buildroot}%{entrydns_root}
cp -R script %{buildroot}%{entrydns_root}
cp -R vendor %{buildroot}%{entrydns_root}
cp -R .bundle %{buildroot}%{entrydns_root}
cp config.ru %{buildroot}%{entrydns_root}


%files
%{entrydns_root}/app
%{entrydns_root}/config
%{entrydns_root}/db
%{entrydns_root}/lib
%{entrydns_root}/log/
%{entrydns_root}/tmp/
%{entrydns_root}/public
%{entrydns_root}/script
%{entrydns_root}/vendor
%{entrydns_root}/.bundle
%{entrydns_root}/config.ru


%pre
getent group %{entrydns_group} >/dev/null || groupadd -r %{entrydns_group}
getent passwd %{entrydns_user} >/dev/null || \
    useradd -r -g %{entrydns_group} -d %{entrydns_root} -s /sbin/nologin \
    -c "EntryDNS user" %{entrydns_user}
exit 0



%changelog
* Tue Feb 5 2013 Vaidas Jablonskis <jablonskis@gmail.com> - 1:0.0.2-1
- initial build
