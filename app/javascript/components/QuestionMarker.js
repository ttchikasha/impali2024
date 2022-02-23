import React, { useState } from 'react';
import PropTypes from 'prop-types';
import Rails from '@rails/ujs';

const updateQuestionAnswerApi = async (url, mark) => {
  let data = new FormData();
  data.append('question_answer[mark]', mark);

  Rails.ajax({
    type: 'PUT',
    url,
    data,
  });
};

const QuestionMarker = (props) => {
  const [mark, setMark] = useState(props.mark || '');
  const [marked, setMarked] = useState(!!props.mark);

  const updateMark = (e) => {
    e.preventDefault();

    updateQuestionAnswerApi(props.url, mark).then((res) => {
      if (res && res.error) {
        console.log('ERROR ->', res.error);
      } else {
        console.log('SUCCESS');
        setMarked(!marked);
      }
    });
  };

  const reMark = (e) => {
    e.preventDefault();
    setMarked(!marked);
  };

  return (
    <React.Fragment>
      <div className='row my-2'>
        <div className='col-md-3 col-sm-5'>
          {marked ? (
            <>
              <button
                style={{ cursor: 'default' }}
                onClick={(e) => e.preventDefault()}
                className={`btn btn-sm rounded-0 ${
                  mark < 50 ? 'btn-outline-danger' : 'btn-outline-success'
                } `}
              >
                {mark}%
              </button>
              <span className='mx-1'></span>
              <button onClick={reMark} className='btn btn-link'>
                <i className='bi bi-pencil text-danger'></i>
              </button>
            </>
          ) : (
            <div className='input-group'>
              <span className='input-group-text'>%</span>
              <input
                type='number'
                min={0}
                max={100}
                className='form-control form-control-sm'
                value={mark}
                onChange={(e) =>
                  setMark(
                    e.target.value > 100
                      ? 100
                      : e.target.value < 0
                      ? 0
                      : e.target.value,
                  )
                }
              />
              <button
                disabled={!mark}
                onClick={updateMark}
                className='btn btn-sm btn-primary'
              >
                Mark
              </button>
            </div>
          )}
        </div>
      </div>
    </React.Fragment>
  );
};

QuestionMarker.propTypes = {
  url: PropTypes.string,
  mark: PropTypes.number,
};

export default QuestionMarker;
