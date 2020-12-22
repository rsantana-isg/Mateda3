%UKF_PREDICT1  Nonaugmented (Additive) UKF prediction step
%
% Syntax:
%   [M,P] = UKF_PREDICT1(M,P,[a,Q,param,alpha,beta,kappa,mat])
%
% In:
%   M - Nx1 mean state estimate of previous step
%   P - NxN state covariance of previous step
%   a - Dynamic model function as a matrix A defining
%       linear function a(x) = A*x, inline function,
%       function handle or name of function in
%       form a(x,param)                   (optional, default eye())
%   Q - Process noise of discrete model   (optional, default zero)
%   param - Parameters of a               (optional, default empty)
%   alpha - Transformation parameter      (optional)
%   beta  - Transformation parameter      (optional)
%   kappa - Transformation parameter      (optional)
%   mat   - If 1 uses matrix form         (optional, default 0)
%
% Out:
%   M - Updated state mean
%   P - Updated state covariance
%
% Description:
%   Perform additive form Unscented Kalman Filter prediction step.
%
%   Function a should be such that it can be given
%   DxN matrix of N sigma Dx1 points and it returns 
%   the corresponding predictions for each sigma
%   point. 
%
% See also:
%   UKF_UPDATE1, UKF_PREDICT2, UKF_UPDATE2, UKF_PREDICT3, UKF_UPDATE3,
%   UT_TRANSFORM, UT_WEIGHTS, UT_MWEIGHTS, UT_SIGMAS

% Copyright (C) 2003-2006 Simo S�rkk�
%
% $Id: ukf_predict1.m 111 2007-09-04 12:09:23Z ssarkka $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function [M,P] = ukf_predict1(M,P,a,Q,param,alpha,beta,kappa,mat)

  %
  % Check which arguments are there
  %
  if nargin < 2
    error('Too few arguments');
  end
  if nargin < 3
    a = [];
  end
  if nargin < 4
    Q = [];
  end
  if nargin < 5
    param = [];
  end
  if nargin < 6
    alpha = [];
  end
  if nargin < 7
    beta = [];
  end
  if nargin < 8
    kappa = [];
  end
  if nargin < 9
    mat = [];
  end

  %
  % Apply defaults
  %
  if isempty(a)
    a = eye(size(M,1));
  end
  if isempty(Q)
    Q = zeros(size(M,1));
  end
  if isempty(mat)
    mat = 0;
  end

  %
  % Do transform
  % and add process noise
  %
  [M,P] = ut_transform(M,P,a,param,alpha,beta,kappa,mat);
  P = P + Q;

