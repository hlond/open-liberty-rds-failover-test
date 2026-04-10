import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
  duration: '60s',
};

export default function () {
  const res = http.get('http://wrapper-test:9080/wrapper-test');
  check(res, { 'status is 200': (res) => res.status === 200 });
  console.log(res.status_text, res.timings);
  console.log(new Date());
  sleep(1);
}
