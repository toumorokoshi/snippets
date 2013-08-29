# Times and generates n jenkins jobs.
# This is to test jenkins capability to handle a large number of
# jobs. (e.g. 100000)

# requires the jenkinsapi egg:
# https://github.com/salimfadhley/jenkinsapi

import time
from jenkinsapi.jenkins import Jenkins

limit = 100000

j = Jenkins('http://localhost:8080')
text_buffer = None
with open('test.xml') as fh:
    text_buffer = fh.read()

print "Deleting jobs..."
for i in range(limit):
    try:
        j.delete_job('job-%d' % i)
    except Exception:
        pass
    print "deleted!"
start_time = time.time()
for i in range(limit):
    print "Creating job #%d..." % i
    j.create_job('job-%d' % i, text_buffer)
print "Success!"
end_time = time.time()
print "Elapsed time: %f" % (end_time - start_time)
