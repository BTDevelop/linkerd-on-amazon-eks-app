import http from 'k6/http';
import { check, sleep } from "k6";

export let options = {
  stages: [
      // simulate ramp-up of traffic from 1 to 100 users over 5 minutes.
      { duration: "1m", target: 100 },
      // stay at 100 users for 10 minutes
      { duration: "3m", target: 100 },
      // ramp-down to 0 users
      { duration: "1m", target: 0 }
  ]
};

export default function () {

  let req = {
    method: 'GET',
    url: 'http://xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-xxxxxxxxx.eu-central-1.elb.amazonaws.com/api/products/1',
  };

  let responses = http.batch([req]);

  for (let i = 0; i < responses.length; i++) {
    check(responses[i], {
      "status is 409": (r) => r.status === 409,
      "status is 500": (r) => r.status === 500,
      "status is 200": (r) => r.status === 200,
      "status is 401": (r) => r.status === 401
    });
  }
};
