#!/usr/bin/env bash

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPTS_DIR")"
MLX_SCRIPT=${SCRIPTS_DIR}/QECD_20k.mlx

USAGE="$(basename "$0") [-h] [-i path/to/input/dir -o path/to/output/dir] [-s path/to/meshlab_script] -- utility program to downsample a set of meshes with meshlabserver

Options:
    -h  shows this help text
    -i  input directory of original mesh files
    -o  output directory to save the downsampled mesh files (will be created if it does not exist)
    -s  path to meshlab script used to downsample (default: ${MLX_SCRIPT})"


if [[ $# -lt 4 ||  "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: $USAGE"
  exit 0
fi


while [[ $# -gt 1 ]]
do
  key="$1"

  case $key in
    -i|--input-dir)
      SHAPES_IN_DIR="$2"
      shift # past argument
      ;;
    -o|--output-dir)
      SHAPES_OUT_DIR="$2"
      shift # past argument
      ;;
    -s|--meshlab-script)
      MLX_SCRIPT="$2"
      shift # past argument
      ;;
    *) # unknown option
    ;;
  esac
  shift # past argument or value
done


if [ ! -f $MLX_SCRIPT ]; then
    echo "File ${MLX_SCRIPT} not found!"
    exit
fi

if [ ! -d "$SHAPES_IN_DIR" ]; then
    echo "Directory ${SHAPES_IN_DIR} does not exist!"
    exit
fi


case "$SHAPES_IN_DIR" in
  */)
     #echo "has slash"
     ;;
   *)
     SHAPES_IN_DIR=$SHAPES_IN_DIR"/"
     #echo "doesn't have a slash"
     ;;
esac


case "$SHAPES_OUT_DIR" in
  */)
     #echo "has slash"
     ;;
   *)
     SHAPES_OUT_DIR=$SHAPES_OUT_DIR"/"
     #echo "doesn't have a slash"
     ;;
esac

echo SHAPES_IN_DIR = "${SHAPES_IN_DIR}"
echo SHAPES_OUT_DIR = "${SHAPES_OUT_DIR}"
echo MLX_SCRIPT = "${MLX_SCRIPT}"


mkdir -p $SHAPES_OUT_DIR
cd $SHAPES_IN_DIR

for i in $( ls );
do
	echo Downsampling shape $i
	meshlabserver -i ${SHAPES_IN_DIR}${i} -o ${SHAPES_OUT_DIR}${i} -s $MLX_SCRIPT
done

