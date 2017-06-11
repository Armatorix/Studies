var mime_samples = [
  { 'mime': 'application/xhtml+xml', 'samples': [
    { 'url': 'http://localhost/phpmyadmin/', 'dir': '_m0/0', 'linked': 2, 'len': 10330 },
    { 'url': 'http://localhost/phpmyadmin/doc/html/index.html', 'dir': '_m0/1', 'linked': 2, 'len': 12811 },
    { 'url': 'http://localhost/bank/', 'dir': '_m0/2', 'linked': 2, 'len': 2965 },
    { 'url': 'http://localhost/phpmyadmin/doc/', 'dir': '_m0/3', 'linked': 5, 'len': 299 },
    { 'url': 'http://localhost/phpmyadmin/doc/html/developers.html', 'dir': '_m0/4', 'linked': 2, 'len': 4949 },
    { 'url': 'http://localhost/phpmyadmin/doc/html/faq.html', 'dir': '_m0/5', 'linked': 2, 'len': 194111 },
    { 'url': 'http://localhost/phpmyadmin/doc/html/import_export.html', 'dir': '_m0/6', 'linked': 2, 'len': 6673 },
    { 'url': 'http://localhost/phpmyadmin/doc/html/index.php', 'dir': '_m0/7', 'linked': 1, 'len': 302 },
    { 'url': 'http://localhost/phpmyadmin/doc/html/other.html', 'dir': '_m0/8', 'linked': 2, 'len': 5782 },
    { 'url': 'http://localhost/phpmyadmin/doc/html/privileges.html', 'dir': '_m0/9', 'linked': 2, 'len': 8348 },
    { 'url': 'http://localhost/phpmyadmin/doc/html/search.html', 'dir': '_m0/10', 'linked': 5, 'len': 3564 },
    { 'url': 'http://localhost/phpmyadmin/setup/', 'dir': '_m0/11', 'linked': 0, 'len': 456 },
    { 'url': 'http://localhost/uwc/', 'dir': '_m0/12', 'linked': 2, 'len': 1306 },
    { 'url': 'http://localhost/webmail/', 'dir': '_m0/13', 'linked': 2, 'len': 1176 } ]
  },
  { 'mime': 'application/zip', 'samples': [
    { 'url': 'http://localhost/phpmyadmin/webapp.php', 'dir': '_m1/0', 'linked': 0, 'len': 9606 } ]
  },
  { 'mime': 'text/css', 'samples': [
    { 'url': 'http://localhost/phpmyadmin/print.css', 'dir': '_m2/0', 'linked': 0, 'len': 1213 },
    { 'url': 'http://localhost/webmail/mail_css_ns6up.css', 'dir': '_m2/1', 'linked': 2, 'len': 18843 },
    { 'url': 'http://localhost/webmail/master-style_ns6up.css', 'dir': '_m2/2', 'linked': 2, 'len': 11140 } ]
  },
  { 'mime': 'text/html', 'samples': [
    { 'url': 'http://localhost/', 'dir': '_m3/0', 'linked': 2, 'len': 12366 },
    { 'url': 'http://localhost/phpmyadmin/templates/javascript/display.phtml', 'dir': '_m3/1', 'linked': 0, 'len': 283 },
    { 'url': 'http://localhost/phpmyadmin/templates/list/item.phtml', 'dir': '_m3/2', 'linked': 0, 'len': 14 },
    { 'url': 'http://localhost/phpmyadmin/templates/navigation/logo.phtml', 'dir': '_m3/3', 'linked': 0, 'len': 75 } ]
  },
  { 'mime': 'text/plain', 'samples': [
    { 'url': 'http://localhost/phpmyadmin/templates/test/static.phtml', 'dir': '_m4/0', 'linked': 0, 'len': 14 } ]
  }
];

var issue_samples = [
  { 'severity': 3, 'type': 40601, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/0' },
    { 'url': 'http://localhost/phpmyadmin/error_report.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/1' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/2' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/3' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/4' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/5' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/6' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/7' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/8' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/9' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/10' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/11' },
    { 'url': 'http://localhost/phpmyadmin/themes.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/12' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/13' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/14' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i0/15' } ]
  },
  { 'severity': 3, 'type': 40101, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/0' },
    { 'url': 'http://localhost/phpmyadmin/error_report.php', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/1' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/2' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/3' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/4' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/5' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/6' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/7' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/8' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/9' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/10' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/11' },
    { 'url': 'http://localhost/phpmyadmin/themes.php', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/12' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/13' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/14' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'injected \x27\x3csfi...\x3e\x27 tag seen in HTML', 'sid': '0', 'dir': '_i1/15' } ]
  },
  { 'severity': 2, 'type': 30701, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/0' },
    { 'url': 'http://localhost/phpmyadmin/error_report.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/1' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/2' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=9876sfi&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/3' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=9876sfi&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/4' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=9876sfi&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/5' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/6' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/7' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/8' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=9876sfi&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/9' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/10' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=9876sfi', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/11' },
    { 'url': 'http://localhost/phpmyadmin/themes.php', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/12' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=9876sfi&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/13' },
    { 'url': 'http://localhost/phpmyadmin/?lang=9876sfi&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/14' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=9876sfi', 'extra': 'conflicting \x27Expires\x27 and \x27Pragma\x27', 'sid': '0', 'dir': '_i2/15' } ]
  },
  { 'severity': 2, 'type': 30601, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/doc/html/search.html?q=1&check_keywords=yes&area=default', 'extra': '', 'sid': '0', 'dir': '_i3/0' },
    { 'url': 'http://localhost/phpmyadmin/doc/html/search.html?q=1&check_keywords=yes&area=default', 'extra': '', 'sid': '0', 'dir': '_i3/1' },
    { 'url': 'http://localhost/phpmyadmin/doc/html/search.html?q=1&check_keywords=yes&area=default', 'extra': '', 'sid': '0', 'dir': '_i3/2' },
    { 'url': 'http://localhost/phpmyadmin/doc/html/search.html?q=1&check_keywords=yes&area=default', 'extra': '', 'sid': '0', 'dir': '_i3/3' },
    { 'url': 'http://localhost/phpmyadmin/doc/html/search.html?q=1&check_keywords=yes&area=default', 'extra': '', 'sid': '0', 'dir': '_i3/4' },
    { 'url': 'http://localhost/phpmyadmin/doc/html/search.html?q=1&check_keywords=yes&area=default', 'extra': '', 'sid': '0', 'dir': '_i3/5' },
    { 'url': 'http://localhost/phpmyadmin/doc/html/search.html?q=1', 'extra': '', 'sid': '0', 'dir': '_i3/6' } ]
  },
  { 'severity': 0, 'type': 10901, 'samples': [
    { 'url': 'http://localhost/webmail/mail_css_ns6up.css', 'extra': '', 'sid': '0', 'dir': '_i4/0' },
    { 'url': 'http://localhost/webmail/master-style_ns6up.css', 'extra': '', 'sid': '0', 'dir': '_i4/1' } ]
  },
  { 'severity': 0, 'type': 10803, 'samples': [
    { 'url': 'http://localhost/', 'extra': '', 'sid': '0', 'dir': '_i5/0' },
    { 'url': 'http://localhost/phpmyadmin/print.css', 'extra': '', 'sid': '0', 'dir': '_i5/1' },
    { 'url': 'http://localhost/webmail/mail_css_ns6up.css', 'extra': '', 'sid': '0', 'dir': '_i5/2' },
    { 'url': 'http://localhost/webmail/master-style_ns6up.css', 'extra': '', 'sid': '0', 'dir': '_i5/3' } ]
  },
  { 'severity': 0, 'type': 10801, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/templates/test/static.phtml', 'extra': 'text/plain', 'sid': '0', 'dir': '_i6/0' } ]
  },
  { 'severity': 0, 'type': 10602, 'samples': [
    { 'url': 'http://localhost/auth', 'extra': '', 'sid': '0', 'dir': '_i7/0' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': '', 'sid': '0', 'dir': '_i7/1' } ]
  },
  { 'severity': 0, 'type': 10601, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': '', 'sid': '0', 'dir': '_i8/0' } ]
  },
  { 'severity': 0, 'type': 10505, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'lang', 'sid': '0', 'dir': '_i9/0' },
    { 'url': 'http://localhost/phpmyadmin/doc/html/index.html', 'extra': 'q', 'sid': '0', 'dir': '_i9/1' } ]
  },
  { 'severity': 0, 'type': 10405, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/setup/', 'extra': '', 'sid': '0', 'dir': '_i10/0' },
    { 'url': 'http://localhost/phpmyadmin/sql/', 'extra': '', 'sid': '0', 'dir': '_i10/1' },
    { 'url': 'http://localhost/phpmyadmin/templates/', 'extra': '', 'sid': '0', 'dir': '_i10/2' },
    { 'url': 'http://localhost/phpmyadmin/templates/components/', 'extra': '', 'sid': '0', 'dir': '_i10/3' },
    { 'url': 'http://localhost/phpmyadmin/templates/javascript/', 'extra': '', 'sid': '0', 'dir': '_i10/4' },
    { 'url': 'http://localhost/phpmyadmin/templates/javascript/display.phtml', 'extra': '', 'sid': '0', 'dir': '_i10/5' },
    { 'url': 'http://localhost/phpmyadmin/templates/list/', 'extra': '', 'sid': '0', 'dir': '_i10/6' },
    { 'url': 'http://localhost/phpmyadmin/templates/list/item.phtml', 'extra': '', 'sid': '0', 'dir': '_i10/7' },
    { 'url': 'http://localhost/phpmyadmin/templates/navigation/', 'extra': '', 'sid': '0', 'dir': '_i10/8' },
    { 'url': 'http://localhost/phpmyadmin/templates/navigation/logo.phtml', 'extra': '', 'sid': '0', 'dir': '_i10/9' },
    { 'url': 'http://localhost/phpmyadmin/templates/table/', 'extra': '', 'sid': '0', 'dir': '_i10/10' },
    { 'url': 'http://localhost/phpmyadmin/templates/table/search/', 'extra': '', 'sid': '0', 'dir': '_i10/11' },
    { 'url': 'http://localhost/phpmyadmin/templates/table/search/options.phtml/', 'extra': '', 'sid': '0', 'dir': '_i10/12' },
    { 'url': 'http://localhost/phpmyadmin/templates/test/', 'extra': '', 'sid': '0', 'dir': '_i10/13' },
    { 'url': 'http://localhost/phpmyadmin/templates/test/static.phtml', 'extra': '', 'sid': '0', 'dir': '_i10/14' },
    { 'url': 'http://localhost/phpmyadmin/print.css', 'extra': '', 'sid': '0', 'dir': '_i10/15' },
    { 'url': 'http://localhost/phpmyadmin/error_report.php', 'extra': '', 'sid': '0', 'dir': '_i10/16' },
    { 'url': 'http://localhost/phpmyadmin/themes.php', 'extra': '', 'sid': '0', 'dir': '_i10/17' },
    { 'url': 'http://localhost/phpmyadmin/webapp.php', 'extra': '', 'sid': '0', 'dir': '_i10/18' } ]
  },
  { 'severity': 0, 'type': 10404, 'samples': [
    { 'url': 'http://localhost/bank/', 'extra': 'Directory listing', 'sid': '0', 'dir': '_i11/0' },
    { 'url': 'http://localhost/uwc/', 'extra': 'Directory listing', 'sid': '0', 'dir': '_i11/1' },
    { 'url': 'http://localhost/webmail/', 'extra': 'Directory listing', 'sid': '0', 'dir': '_i11/2' },
    { 'url': 'http://localhost/webmail/?C=9876sfi;O=D', 'extra': 'Directory listing', 'sid': '0', 'dir': '_i11/3' },
    { 'url': 'http://localhost/webmail/?C=N;O=9876sfi', 'extra': 'Directory listing', 'sid': '0', 'dir': '_i11/4' } ]
  },
  { 'severity': 0, 'type': 10403, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/templates/table/search/options.phtml/', 'extra': '', 'sid': '0', 'dir': '_i12/0' } ]
  },
  { 'severity': 0, 'type': 10402, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/setup/', 'extra': '', 'sid': '0', 'dir': '_i13/0' } ]
  },
  { 'severity': 0, 'type': 10401, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/setup/', 'extra': '', 'sid': '0', 'dir': '_i14/0' },
    { 'url': 'http://localhost/phpmyadmin/templates/table/search/options.phtml/', 'extra': '', 'sid': '0', 'dir': '_i14/1' } ]
  },
  { 'severity': 0, 'type': 10205, 'samples': [
    { 'url': 'http://localhost/sfi9876', 'extra': '', 'sid': '0', 'dir': '_i15/0' },
    { 'url': 'http://localhost/sfi9876.phps', 'extra': '', 'sid': '0', 'dir': '_i15/1' } ]
  },
  { 'severity': 0, 'type': 10204, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'X-ob_mode', 'sid': '0', 'dir': '_i16/0' },
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'X-Frame-Options', 'sid': '0', 'dir': '_i16/1' },
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'X-Content-Security-Policy', 'sid': '0', 'dir': '_i16/2' },
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'X-WebKit-CSP', 'sid': '0', 'dir': '_i16/3' },
    { 'url': 'http://localhost/phpmyadmin/doc/', 'extra': 'X-ob_mode', 'sid': '0', 'dir': '_i16/4' },
    { 'url': 'http://localhost/phpmyadmin/doc/', 'extra': 'X-Frame-Options', 'sid': '0', 'dir': '_i16/5' },
    { 'url': 'http://localhost/phpmyadmin/doc/', 'extra': 'X-Content-Security-Policy', 'sid': '0', 'dir': '_i16/6' },
    { 'url': 'http://localhost/phpmyadmin/doc/', 'extra': 'X-WebKit-CSP', 'sid': '0', 'dir': '_i16/7' },
    { 'url': 'http://localhost/phpmyadmin/setup/', 'extra': 'X-ob_mode', 'sid': '0', 'dir': '_i16/8' },
    { 'url': 'http://localhost/phpmyadmin/setup/', 'extra': 'X-Frame-Options', 'sid': '0', 'dir': '_i16/9' },
    { 'url': 'http://localhost/phpmyadmin/setup/', 'extra': 'X-Content-Security-Policy', 'sid': '0', 'dir': '_i16/10' },
    { 'url': 'http://localhost/phpmyadmin/setup/', 'extra': 'X-WebKit-CSP', 'sid': '0', 'dir': '_i16/11' },
    { 'url': 'http://localhost/phpmyadmin/sql/', 'extra': 'X-ob_mode', 'sid': '0', 'dir': '_i16/12' },
    { 'url': 'http://localhost/phpmyadmin/sql/', 'extra': 'X-Frame-Options', 'sid': '0', 'dir': '_i16/13' },
    { 'url': 'http://localhost/phpmyadmin/sql/', 'extra': 'X-Content-Security-Policy', 'sid': '0', 'dir': '_i16/14' },
    { 'url': 'http://localhost/phpmyadmin/sql/', 'extra': 'X-WebKit-CSP', 'sid': '0', 'dir': '_i16/15' },
    { 'url': 'http://localhost/phpmyadmin/templates/', 'extra': 'X-ob_mode', 'sid': '0', 'dir': '_i16/16' },
    { 'url': 'http://localhost/phpmyadmin/templates/', 'extra': 'X-Frame-Options', 'sid': '0', 'dir': '_i16/17' },
    { 'url': 'http://localhost/phpmyadmin/templates/', 'extra': 'X-Content-Security-Policy', 'sid': '0', 'dir': '_i16/18' },
    { 'url': 'http://localhost/phpmyadmin/templates/', 'extra': 'X-WebKit-CSP', 'sid': '0', 'dir': '_i16/19' },
    { 'url': 'http://localhost/phpmyadmin/webapp.php', 'extra': 'X-ob_mode', 'sid': '0', 'dir': '_i16/20' },
    { 'url': 'http://localhost/phpmyadmin/webapp.php', 'extra': 'X-Frame-Options', 'sid': '0', 'dir': '_i16/21' },
    { 'url': 'http://localhost/phpmyadmin/webapp.php', 'extra': 'X-Content-Security-Policy', 'sid': '0', 'dir': '_i16/22' },
    { 'url': 'http://localhost/phpmyadmin/webapp.php', 'extra': 'X-WebKit-CSP', 'sid': '0', 'dir': '_i16/23' } ]
  },
  { 'severity': 0, 'type': 10202, 'samples': [
    { 'url': 'http://localhost/', 'extra': 'Apache/2.4.18 (Ubuntu)', 'sid': '0', 'dir': '_i17/0' } ]
  },
  { 'severity': 0, 'type': 10201, 'samples': [
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/0' },
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/1' },
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/2' },
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'pma_collation_connection', 'sid': '0', 'dir': '_i18/3' },
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/4' },
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/5' },
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/6' },
    { 'url': 'http://localhost/phpmyadmin/', 'extra': 'pma_collation_connection', 'sid': '0', 'dir': '_i18/7' },
    { 'url': 'http://localhost/phpmyadmin/error_report.php', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/8' },
    { 'url': 'http://localhost/phpmyadmin/error_report.php', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/9' },
    { 'url': 'http://localhost/phpmyadmin/error_report.php', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/10' },
    { 'url': 'http://localhost/phpmyadmin/error_report.php', 'extra': 'pma_collation_connection', 'sid': '0', 'dir': '_i18/11' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/12' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/13' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/14' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pma_collation_connection', 'sid': '0', 'dir': '_i18/15' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/16' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/17' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/18' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/19' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/20' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/21' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/22' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/23' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/24' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/25' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/26' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/27' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pmaPass-1', 'sid': '0', 'dir': '_i18/28' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/29' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/30' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/31' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/32' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/33' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/34' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/35' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/36' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/37' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/38' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/39' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/40' },
    { 'url': 'http://localhost/phpmyadmin/index.php', 'extra': 'pma_collation_connection', 'sid': '0', 'dir': '_i18/41' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/42' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/43' },
    { 'url': 'http://localhost/phpmyadmin/index.php?db=&table=&lang=1&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/44' },
    { 'url': 'http://localhost/phpmyadmin/themes.php', 'extra': 'pma_collation_connection', 'sid': '0', 'dir': '_i18/45' },
    { 'url': 'http://localhost/phpmyadmin/themes.php', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/46' },
    { 'url': 'http://localhost/phpmyadmin/themes.php', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/47' },
    { 'url': 'http://localhost/phpmyadmin/themes.php', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/48' },
    { 'url': 'http://localhost/phpmyadmin/webapp.php', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/49' },
    { 'url': 'http://localhost/phpmyadmin/webapp.php', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/50' },
    { 'url': 'http://localhost/phpmyadmin/webapp.php', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/51' },
    { 'url': 'http://localhost/phpmyadmin/webapp.php', 'extra': 'pma_collation_connection', 'sid': '0', 'dir': '_i18/52' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/53' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/54' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/55' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pma_collation_connection', 'sid': '0', 'dir': '_i18/56' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/57' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/58' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/59' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pmaCookieVer', 'sid': '0', 'dir': '_i18/60' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'phpMyAdmin', 'sid': '0', 'dir': '_i18/61' },
    { 'url': 'http://localhost/phpmyadmin/?lang=en&collation_connection=utf8_unicode_ci&token=5f7541e1c8918cb0ac7272576ea440a1', 'extra': 'pma_lang', 'sid': '0', 'dir': '_i18/62' } ]
  }
];

