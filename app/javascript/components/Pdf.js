import React from "react";
import PropTypes from "prop-types";
import FileViewer from "react-file-viewer";

class Pdf extends React.Component {
  onError(e) {
    console.log(e, "error in file-viewer");
  }

  render() {
    return (
      <FileViewer
        fileType={"pdf"}
        filePath={this.props.url}
        onError={this.onError}
      />
    );
  }
}

Pdf.propTypes = {
  url: PropTypes.string,
};

export default Pdf;
