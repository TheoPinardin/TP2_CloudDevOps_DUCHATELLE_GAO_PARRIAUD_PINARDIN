if [ -f lambda_function_package.zip ]; then
  rm lambda_function_package.zip
fi
mkdir lambda_package
npm --prefix src/"$1" run build
cp -r src/"$1"/build/* lambda_package/
cd lambda_package || exit
zip -r ../lambda_function_package.zip *
cd ..
rm -rf lambda_package
aws lambda update-function-code  --function-name "$1" --zip-file fileb://lambda_function_package.zip  --region "eu-west-1"
rm -f lambda_function_package.zip
