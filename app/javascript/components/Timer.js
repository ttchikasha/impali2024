import React, { useRef, useState } from 'react';
import PropTypes from 'prop-types';
import Countdown from 'react-countdown';

const Timer = ({ due }) => {
  const myRefname = useRef(null);
  const [text, setText] = useState('');

  const completed = () => {
    console.log('We have stopped');
    setText('Time up - submit your answers now');
    const additionalTime = 60000;
    setTimeout(() => {
      myRefname.current.click();
    }, additionalTime);
  };

  return (
    <React.Fragment>
      <Countdown date={due} onComplete={completed} />
      <h5 className='text-danger'>{text}</h5>
      <a className='d-none' ref={myRefname} href=''>
        Hi there
      </a>
    </React.Fragment>
  );
};

Timer.propTypes = {
  due: PropTypes.string,
};

export default Timer;
